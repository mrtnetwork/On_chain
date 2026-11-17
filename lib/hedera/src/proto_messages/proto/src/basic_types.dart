import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart" as google_protobuf_wrappers;

/// *
///  * A specific hash algorithm.
///  *
///  * We did not reuse Record Stream `HashAlgorithm` here because in all cases,
///  * currently, this will be `SHA2_384` and if that is the default value then
///  * we can save space by not serializing it, whereas `HASH_ALGORITHM_UNKNOWN`
///  * is the default for Record Stream `HashAlgorithm`.
///  *
///  * Note that enum values here MUST NOT match the name of any other enum value
///  * in the same `package`, as protobuf follows `C++` scope rules and all enum
///  * _names_ are treated as global constants within the `package`.
enum HederaBlockHashAlgorithm implements ProtoEnumVariant {
    /// *
  ///      * A SHA2 algorithm SHA-384 hash.
  ///      * &lt;p&gt;
  ///      * This is the default value, if a field of this enumerated type is
  ///      * not set, then this is the value that will be decoded when the
  ///      * serialized message is read.
  sha2384(0, 'SHA2_384');

  const HederaBlockHashAlgorithm(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaBlockHashAlgorithm fromValue(int? value) {
    value ??=0;
    return HederaBlockHashAlgorithm.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaBlockHashAlgorithm found for the given value. $value", details: {"name": "HederaBlockHashAlgorithm", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaBlockHashAlgorithm from(Object? value) {
    value ??=0;
    return HederaBlockHashAlgorithm.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaBlockHashAlgorithm found for the given value. $value", details: {"name": "HederaBlockHashAlgorithm", "value": value?.toString()})
    );
  }

}


/// *
///  * Possible Token Types (IWA Compatibility).
///  *
///  * Apart from fungible and non-fungible, Tokens can have either a common or
///  * unique representation. Furthermore, tokens can have intrinsic or referential
///  * value, and can be whole and indivisible or fractional.&lt;br/&gt;
///  * These distinction might seem subtle, but it is important when considering
///  * how tokens can be traced, used, transferred, and if they can have isolated
///  * unique properties.
///  *
///  * A few examples (these may not match enumerations below) using IWA taxonomy.
///  * &lt;dl&gt;
///  *   &lt;dt&gt;fungible, whole, intrinsic, unique&lt;/dt&gt;
///  *     &lt;dd&gt;Physical fiat currency&lt;/dd&gt;
///  *   &lt;dt&gt;fungible, fractional, intrinsic, common&lt;/dt&gt;
///  *     &lt;dd&gt;bank balance fiat currency&lt;/dd&gt;
///  *   &lt;dt&gt;non-fungible, fractional, reference, unique&lt;/dt&gt;
///  *     &lt;dd&gt;"mutual" collectible/art/property ownership&lt;/dd&gt;
///  *   &lt;dt&gt;non-fungible, whole, intrinsic, unique&lt;/dt&gt;
///  *     &lt;dd&gt;Physical work of fine art&lt;/dd&gt;
///  *   &lt;dt&gt;non-fungible, whole, reference, unique&lt;/dt&gt;
///  *     &lt;dd&gt;Registered property title&lt;/dd&gt;
///  * &lt;/dl&gt;
enum HederaTokenType implements ProtoEnumVariant {
    /// *
  ///      * A fungible/common token.&lt;br/&gt;
  ///      * Tokens of this type are interchangeable with one another, where any
  ///      * quantity of tokens has the same value as another equal quantity, if
  ///      * they are in the same class. Tokens share a single set of properties,
  ///      * and are not distinct from one another. Ownership is represented as a
  ///      * balance or quantity associated to a given account. Tokens may be
  ///      * divided into fractional tokens, within reasonable limits.
  ///      * &lt;p&gt;
  ///      * IWA taxonomy _fungible, fractional, intrinsic, common_
  fungibleCommon(0, 'FUNGIBLE_COMMON'),
    /// *
  ///      * A non-fungible/unique token.&lt;br/&gt;
  ///      * Tokens of this type are unique, and are not interchangeable with other
  ///      * tokens of the same type. Each token carries a serial number which is
  ///      * unique for that token, these tokens may have a different trade value
  ///      * for each individual token. The tokens are individually accounted and
  ///      * often carry additional unique properties. Tokens cannot be subdivided,
  ///      * and value is related to what the individual token represents.
  ///      * &lt;p&gt;
  ///      * IWA taxonomy _non-fungible, whole, reference, unique_
  nonFungibleUnique(1, 'NON_FUNGIBLE_UNIQUE');

  const HederaTokenType(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaTokenType fromValue(int? value) {
    value ??=0;
    return HederaTokenType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenType found for the given value. $value", details: {"name": "HederaTokenType", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaTokenType from(Object? value) {
    value ??=0;
    return HederaTokenType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenType found for the given value. $value", details: {"name": "HederaTokenType", "value": value?.toString()})
    );
  }

}


/// *
///  * A transaction sub type.&lt;br/&gt;
///  * This enumeration enables a set of transaction base fees to be broadly
///  * defined for a type of operation and also be modified, when necessary,
///  * based on specifics of the operation.
///  *
///  * ### Explanation
///  * The resource cost for a TokenMint operation is different between minting
///  * fungible/common and non-fungible/unique tokens. This `enum` is used to
///  * "mark" a cost as applying to one or the other.&lt;br/&gt;
///  * Similarly, the resource cost for a basic `tokenCreate` without a custom
///  * fee schedule may yield a _base_ fee of $1. The resource cost for a
///  * `tokenCreate` _with_ a custom fee schedule is different and may yield a
///  * _base_ fee of $2 or more.
enum HederaSubType implements ProtoEnumVariant {
    /// *
  ///      * The resource cost for the transaction type has no additional attributes
  default_(0, 'DEFAULT'),
    /// *
  ///      * The resource cost for the transaction type includes an operation on a
  ///      * fungible/common token
  tokenFungibleCommon(1, 'TOKEN_FUNGIBLE_COMMON'),
    /// *
  ///      * The resource cost for the transaction type includes an operation on
  ///      * a non-fungible/unique token
  tokenNonFungibleUnique(2, 'TOKEN_NON_FUNGIBLE_UNIQUE'),
    /// *
  ///      * The resource cost for the transaction type includes an operation on a
  ///      * fungible/common token with a custom fee schedule
  tokenFungibleCommonWithCustomFees(3, 'TOKEN_FUNGIBLE_COMMON_WITH_CUSTOM_FEES'),
    /// *
  ///      * The resource cost for the transaction type includes an operation on a
  ///      * non-fungible/unique token with a custom fee schedule
  tokenNonFungibleUniqueWithCustomFees(4, 'TOKEN_NON_FUNGIBLE_UNIQUE_WITH_CUSTOM_FEES'),
    /// *
  ///      * The resource cost for the transaction type includes a ScheduleCreate
  ///      * containing a ContractCall.
  scheduleCreateContractCall(5, 'SCHEDULE_CREATE_CONTRACT_CALL'),
    /// *
  ///      * The resource cost for the transaction type includes a TopicCreate
  ///      * with custom fees.
  topicCreateWithCustomFees(6, 'TOPIC_CREATE_WITH_CUSTOM_FEES'),
    /// *
  ///      * The resource cost for the transaction type includes a ConsensusSubmitMessage
  ///      * for a topic with custom fees.
  submitMessageWithCustomFees(7, 'SUBMIT_MESSAGE_WITH_CUSTOM_FEES'),
    /// *
  ///      * The resource cost for the transaction type that includes a CryptoTransfer with hook invocations
  cryptoTransferWithHooks(8, 'CRYPTO_TRANSFER_WITH_HOOKS');

  const HederaSubType(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaSubType fromValue(int? value) {
    value ??=0;
    return HederaSubType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaSubType found for the given value. $value", details: {"name": "HederaSubType", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaSubType from(Object? value) {
    value ??=0;
    return HederaSubType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaSubType found for the given value. $value", details: {"name": "HederaSubType", "value": value?.toString()})
    );
  }

}


/// *
///  * Possible Token Supply Types (IWA Compatibility).
///  *
///  * This `enum` indicates the limit of tokens that can exist during the
///  * lifetime of a token definition. The "infinite" supply is only theoretically
///  * infinite, as it is still limited to the magnitude of a 64-bit signed
///  * integer. A "finite" supply is further limited to a value specified when
///  * the token is created (or updated, if not immutable).
enum HederaTokenSupplyType implements ProtoEnumVariant {
    /// *
  ///      * An unlimited supply.&lt;br/&gt;
  ///      * This indicates that tokens of this type have an upper bound of
  ///      * Long.MAX_VALUE.&lt;br/&gt;
  ///      * The supply is accounted in the smallest units of the token
  ///      * (i.e. 10&lt;sup&gt;-`decimals`&lt;/sup&gt; whole tokens)
  infinite(0, 'INFINITE'),
    /// *
  ///      * A limited supply.&lt;br/&gt;
  ///      * This indicates that tokens of this type have an upper bound of
  ///      * `maxSupply`.&lt;br/&gt;
  ///      * The maximum supply SHALL be provided on token creation, but MAY be
  ///      * changed thereafter if the token has an `admin_key` set.
  finite(1, 'FINITE');

  const HederaTokenSupplyType(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaTokenSupplyType fromValue(int? value) {
    value ??=0;
    return HederaTokenSupplyType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenSupplyType found for the given value. $value", details: {"name": "HederaTokenSupplyType", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaTokenSupplyType from(Object? value) {
    value ??=0;
    return HederaTokenSupplyType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenSupplyType found for the given value. $value", details: {"name": "HederaTokenSupplyType", "value": value?.toString()})
    );
  }

}


/// *
///  * Types of validation strategies for token keys.
enum HederaTokenKeyValidation implements ProtoEnumVariant {
    /// *
  ///      * Perform all token key validations.&lt;br/&gt;
  ///      * This is the default value and behavior.
  fullValidation(0, 'FULL_VALIDATION'),
    /// *
  ///      * Perform no validations at all for all passed token keys.
  noValidation(1, 'NO_VALIDATION');

  const HederaTokenKeyValidation(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaTokenKeyValidation fromValue(int? value) {
    value ??=0;
    return HederaTokenKeyValidation.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenKeyValidation found for the given value. $value", details: {"name": "HederaTokenKeyValidation", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaTokenKeyValidation from(Object? value) {
    value ??=0;
    return HederaTokenKeyValidation.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenKeyValidation found for the given value. $value", details: {"name": "HederaTokenKeyValidation", "value": value?.toString()})
    );
  }

}


/// *
///  * Possible token freeze status values.
///  *
///  * This is returned by `TokenGetInfoQuery` or `CryptoGetInfoResponse`
///  * in `TokenRelationship`.
enum HederaTokenFreezeStatus implements ProtoEnumVariant {
    /// *
  ///      * The token does not support freeze or cannot be frozen for the designated
  ///      * account.&lt;br/&gt;
  ///      * Typically this indicates that the token does not have a `freeze_key` set.
  freezeNotApplicable(0, 'FreezeNotApplicable'),
    /// *
  ///      * The token is currently frozen for the designated account.
  frozen(1, 'Frozen'),
    /// *
  ///      * The token is not currently frozen for the designated account.
  unfrozen(2, 'Unfrozen');

  const HederaTokenFreezeStatus(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaTokenFreezeStatus fromValue(int? value) {
    value ??=0;
    return HederaTokenFreezeStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenFreezeStatus found for the given value. $value", details: {"name": "HederaTokenFreezeStatus", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaTokenFreezeStatus from(Object? value) {
    value ??=0;
    return HederaTokenFreezeStatus.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenFreezeStatus found for the given value. $value", details: {"name": "HederaTokenFreezeStatus", "value": value?.toString()})
    );
  }

}


/// *
///  * Possible token "KYC" status values.
///  *
///  * This is returned by `TokenGetInfoQuery` or `CryptoGetInfoResponse`
///  * in `TokenRelationship`.
enum HederaTokenKycStatus implements ProtoEnumVariant {
    /// *
  ///      * The token does not support KYC or cannot grant KYC for the
  ///      * designated account.&lt;br/&gt;
  ///      * Typically this indicates that the token does not have a `kyc_key` set.
  kycNotApplicable(0, 'KycNotApplicable'),
    /// *
  ///      * The designated account is currently granted KYC status for the
  ///      * designated token.
  granted(1, 'Granted'),
    /// *
  ///      * The designated account is not currently granted KYC status for the
  ///      * designated token.
  revoked(2, 'Revoked');

  const HederaTokenKycStatus(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaTokenKycStatus fromValue(int? value) {
    value ??=0;
    return HederaTokenKycStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenKycStatus found for the given value. $value", details: {"name": "HederaTokenKycStatus", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaTokenKycStatus from(Object? value) {
    value ??=0;
    return HederaTokenKycStatus.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenKycStatus found for the given value. $value", details: {"name": "HederaTokenKycStatus", "value": value?.toString()})
    );
  }

}


/// *
///  * Possible Pause status values.
///  *
///  * This is returned by `TokenGetInfoQuery` in `TokenRelationship`.
enum HederaTokenPauseStatus implements ProtoEnumVariant {
    /// *
  ///      * The token does not support pause or cannot be paused.&lt;br/&gt;
  ///      * Typically this indicates that the token does not have a `pause_key` set.
  pauseNotApplicable(0, 'PauseNotApplicable'),
    /// *
  ///      * The token is currently paused.
  paused(1, 'Paused'),
    /// *
  ///      * The token is not currently paused.
  unpaused(2, 'Unpaused');

  const HederaTokenPauseStatus(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaTokenPauseStatus fromValue(int? value) {
    value ??=0;
    return HederaTokenPauseStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenPauseStatus found for the given value. $value", details: {"name": "HederaTokenPauseStatus", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaTokenPauseStatus from(Object? value) {
    value ??=0;
    return HederaTokenPauseStatus.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaTokenPauseStatus found for the given value. $value", details: {"name": "HederaTokenPauseStatus", "value": value?.toString()})
    );
  }

}


/// *
///  * The transactions and queries supported by Hedera Hashgraph.
enum HederaHederaFunctionality implements ProtoEnumVariant {
    /// FUTURE - Uncomment when https://github.com/hashgraph/pbj/issues/339 is fixed;
  /// currently the PBJ-generated unit tests fail when using reserved ordinals
  /// reserved 96, 97, 98, 99;
  /// *
  ///      * Unused - The first value is unused because this default value is
  ///      * ambiguous with an "unset" value and therefore should not be used.
  none(0, 'NONE'),
    /// *
  ///      * Transfer tokens among accounts.
  cryptoTransfer(1, 'CryptoTransfer'),
    /// *
  ///      * Update an account.
  cryptoUpdate(2, 'CryptoUpdate'),
    /// *
  ///      * Delete an account.
  cryptoDelete(3, 'CryptoDelete'),
    /// *
  ///      * Add a livehash to an account
  cryptoAddLiveHash(4, 'CryptoAddLiveHash'),
    /// *
  ///      * Delete a livehash from an account
  cryptoDeleteLiveHash(5, 'CryptoDeleteLiveHash'),
    /// *
  ///      * Execute a smart contract call.
  contractCall(6, 'ContractCall'),
    /// *
  ///      * Create a smart contract.
  contractCreate(7, 'ContractCreate'),
    /// *
  ///      * Update a smart contract.
  contractUpdate(8, 'ContractUpdate'),
    /// *
  ///      * Create a "file" stored in the ledger.
  fileCreate(9, 'FileCreate'),
    /// *
  ///      * Append data to a "file" stored in the ledger.
  fileAppend(10, 'FileAppend'),
    /// *
  ///      * Update a "file" stored in the ledger.
  fileUpdate(11, 'FileUpdate'),
    /// *
  ///      * Delete a "file" stored in the ledger.
  fileDelete(12, 'FileDelete'),
    /// *
  ///      * Get the balance for an account.
  cryptoGetAccountBalance(13, 'CryptoGetAccountBalance'),
    /// *
  ///      * Get a full account record.
  cryptoGetAccountRecords(14, 'CryptoGetAccountRecords'),
    /// *
  ///      * Get information about a token.
  cryptoGetInfo(15, 'CryptoGetInfo'),
    /// *
  ///      * Execute a local smart contract call.&lt;br/&gt;
  ///      * Used by contracts to call other contracts.
  contractCallLocal(16, 'ContractCallLocal'),
    /// *
  ///      * Get information about a smart contract.
  contractGetInfo(17, 'ContractGetInfo'),
    /// *
  ///      * Get the compiled bytecode that implements a smart contract.
  contractGetBytecode(18, 'ContractGetBytecode'),
    /// *
  ///      * Get a smart contract record by reference to the solidity ID.
  getBySolidityID(19, 'GetBySolidityID'),
    /// *
  ///      * Get a smart contract by reference to the contract key.
  getByKey(20, 'GetByKey'),
    /// *
  ///      * Get the live hash for an account
  cryptoGetLiveHash(21, 'CryptoGetLiveHash'),
    /// *
  ///      * Get the accounts proxy staking to a given account.
  cryptoGetStakers(22, 'CryptoGetStakers'),
    /// *
  ///      * Get the contents of a "file" stored in the ledger.
  fileGetContents(23, 'FileGetContents'),
    /// *
  ///      * Get the metadata for a "file" stored in the ledger.
  fileGetInfo(24, 'FileGetInfo'),
    /// *
  ///      * Get transaction record(s) for a specified transaction ID.
  transactionGetRecord(25, 'TransactionGetRecord'),
    /// *
  ///      * Get all transaction records for a specified contract ID in
  ///      * the past 24 hours.&lt;br/&gt;
  ///      * deprecated since version 0.9.0
  contractGetRecords(26, 'ContractGetRecords'),
    /// *
  ///      * Create a new account
  cryptoCreate(27, 'CryptoCreate'),
    /// *
  ///      * Delete a "system" "file" stored in the ledger.&lt;br/&gt;
  ///      * "System" files are files with special purpose and ID values within a
  ///      * specific range.&lt;br/&gt;
  ///      * These files require additional controls and can only be deleted when
  ///      * authorized by accounts with elevated privilege.
  systemDelete(28, 'SystemDelete'),
    /// *
  ///      * Undo the delete of a "system" "file" stored in the ledger.&lt;br/&gt;
  ///      * "System" files are files with special purpose and ID values within a
  ///      * specific range.&lt;br/&gt;
  ///      * These files require additional controls and can only be deleted when
  ///      * authorized by accounts with elevated privilege. This operation allows
  ///      * such files to be restored, within a reasonable timeframe, if
  ///      * deleted improperly.
  systemUndelete(29, 'SystemUndelete'),
    /// *
  ///      * Delete a smart contract
  contractDelete(30, 'ContractDelete'),
    /// *
  ///      * Stop all processing and "freeze" the entire network.&lt;br/&gt;
  ///      * This is generally sent immediately prior to upgrading the network.&lt;br/&gt;
  ///      * After processing this transactions all nodes enter a quiescent state.
  freeze(31, 'Freeze'),
    /// *
  ///      * Create a Transaction Record.&lt;br/&gt;
  ///      * This appears to be purely internal and unused.
  createTransactionRecord(32, 'CreateTransactionRecord'),
    /// *
  ///      * Auto-renew an account.&lt;br/&gt;
  ///      * This is used for internal fee calculations.
  cryptoAccountAutoRenew(33, 'CryptoAccountAutoRenew'),
    /// *
  ///      * Auto-renew a smart contract.&lt;br/&gt;
  ///      * This is used for internal fee calculations.
  contractAutoRenew(34, 'ContractAutoRenew'),
    /// *
  ///      * Get version information for the ledger.&lt;br/&gt;
  ///      * This returns a the version of the software currently running the network
  ///      * for both the protocol buffers and the network services (node).
  getVersionInfo(35, 'GetVersionInfo'),
    /// *
  ///      * Get a receipt for a specified transaction ID.
  transactionGetReceipt(36, 'TransactionGetReceipt'),
    /// *
  ///      * Create a topic for the Hedera Consensus Service (HCS).
  consensusCreateTopic(50, 'ConsensusCreateTopic'),
    /// *
  ///      * Update an HCS topic.
  consensusUpdateTopic(51, 'ConsensusUpdateTopic'),
    /// *
  ///      * Delete an HCS topic.
  consensusDeleteTopic(52, 'ConsensusDeleteTopic'),
    /// *
  ///      * Get metadata (information) for an HCS topic.
  consensusGetTopicInfo(53, 'ConsensusGetTopicInfo'),
    /// *
  ///      * Publish a message to an HCS topic.
  consensusSubmitMessage(54, 'ConsensusSubmitMessage'),
    /// *
  ///      * Submit a transaction, bypassing intake checking.
  ///      * Only enabled in local-mode.
  uncheckedSubmit(55, 'UncheckedSubmit'),
    /// *
  ///      * Create a token for the Hedera Token Service (HTS).
  tokenCreate(56, 'TokenCreate'),
    /// *
  ///      * Get metadata (information) for an HTS token.
  tokenGetInfo(58, 'TokenGetInfo'),
    /// *
  ///      * Freeze a specific account with respect to a specific HTS token.
  ///      * &lt;p&gt;
  ///      * Once this transaction completes that account CANNOT send or receive
  ///      * the specified token.
  tokenFreezeAccount(59, 'TokenFreezeAccount'),
    /// *
  ///      * Remove a "freeze" from an account with respect to a specific HTS token.
  tokenUnfreezeAccount(60, 'TokenUnfreezeAccount'),
    /// *
  ///      * Grant KYC status to an account for a specific HTS token.
  tokenGrantKycToAccount(61, 'TokenGrantKycToAccount'),
    /// *
  ///      * Revoke KYC status from an account for a specific HTS token.
  tokenRevokeKycFromAccount(62, 'TokenRevokeKycFromAccount'),
    /// *
  ///      * Delete a specific HTS token.
  tokenDelete(63, 'TokenDelete'),
    /// *
  ///      * Update a specific HTS token.
  tokenUpdate(64, 'TokenUpdate'),
    /// *
  ///      * Mint HTS token amounts to the treasury account for that token.
  tokenMint(65, 'TokenMint'),
    /// *
  ///      * Burn HTS token amounts from the treasury account for that token.
  tokenBurn(66, 'TokenBurn'),
    /// *
  ///      * Wipe all amounts for a specific HTS token from a specified account.
  tokenAccountWipe(67, 'TokenAccountWipe'),
    /// *
  ///      * Associate a specific HTS token to an account.
  tokenAssociateToAccount(68, 'TokenAssociateToAccount'),
    /// *
  ///      * Dissociate a specific HTS token from an account.
  tokenDissociateFromAccount(69, 'TokenDissociateFromAccount'),
    /// *
  ///      * Create a scheduled transaction
  scheduleCreate(70, 'ScheduleCreate'),
    /// *
  ///      * Delete a scheduled transaction
  scheduleDelete(71, 'ScheduleDelete'),
    /// *
  ///      * Sign a scheduled transaction
  scheduleSign(72, 'ScheduleSign'),
    /// *
  ///      * Get metadata (information) for a scheduled transaction
  scheduleGetInfo(73, 'ScheduleGetInfo'),
    /// *
  ///      * Get NFT metadata (information) for a range of NFTs associated to a
  ///      * specific non-fungible/unique HTS token and owned by a specific account.
  tokenGetAccountNftInfos(74, 'TokenGetAccountNftInfos'),
    /// *
  ///      * Get metadata (information) for a specific NFT identified by token and
  ///      * serial number.
  tokenGetNftInfo(75, 'TokenGetNftInfo'),
    /// *
  ///      * Get NFT metadata (information) for a range of NFTs associated to a
  ///      * specific non-fungible/unique HTS token.
  tokenGetNftInfos(76, 'TokenGetNftInfos'),
    /// *
  ///      * Update a token's custom fee schedule.
  ///      * &lt;p&gt;
  ///      * If a transaction of this type is not signed by the token
  ///      * `fee_schedule_key` it SHALL fail with INVALID_SIGNATURE, or
  ///      * TOKEN_HAS_NO_FEE_SCHEDULE_KEY if there is no `fee_schedule_key` set.
  tokenFeeScheduleUpdate(77, 'TokenFeeScheduleUpdate'),
    /// *
  ///      * Get execution time(s) for one or more "recent" TransactionIDs.
  networkGetExecutionTime(78, 'NetworkGetExecutionTime'),
    /// *
  ///      * Pause a specific HTS token
  tokenPause(79, 'TokenPause'),
    /// *
  ///      * Unpause a paused HTS token.
  tokenUnpause(80, 'TokenUnpause'),
    /// *
  ///      * Approve an allowance for a spender relative to the owner account, which
  ///      * MUST sign the transaction.
  cryptoApproveAllowance(81, 'CryptoApproveAllowance'),
    /// *
  ///      * Delete (unapprove) an allowance previously approved
  ///      * for the owner account.
  cryptoDeleteAllowance(82, 'CryptoDeleteAllowance'),
    /// *
  ///      * Get all the information about an account, including balance
  ///      * and allowances.&lt;br/&gt;
  ///      * This does not get a list of account records.
  getAccountDetails(83, 'GetAccountDetails'),
    /// *
  ///      * Perform an Ethereum (EVM) transaction.&lt;br/&gt;
  ///      * CallData may be inline if small, or in a "file" if large.
  ethereumTransaction(84, 'EthereumTransaction'),
    /// *
  ///      * Used to indicate when the network has updated the staking information
  ///      * at the end of a staking period and to indicate a new staking period
  ///      * has started.
  nodeStakeUpdate(85, 'NodeStakeUpdate'),
    /// *
  ///      * Generate and return a pseudorandom number based on network state.
  utilPrng(86, 'UtilPrng'),
    /// *
  ///      * Get a record for a "recent" transaction.
  transactionGetFastRecord(87, 'TransactionGetFastRecord'),
    /// *
  ///      * Update the metadata of one or more NFT's of a specific token type.
  tokenUpdateNfts(88, 'TokenUpdateNfts'),
    /// *
  ///      * Create a node
  nodeCreate(89, 'NodeCreate'),
    /// *
  ///      * Update a node
  nodeUpdate(90, 'NodeUpdate'),
    /// *
  ///      * Delete a node
  nodeDelete(91, 'NodeDelete'),
    /// *
  ///      * Transfer one or more token balances held by the requesting account
  ///      * to the treasury for each token type.
  tokenReject(92, 'TokenReject'),
    /// *
  ///      * Airdrop one or more tokens to one or more accounts.
  tokenAirdrop(93, 'TokenAirdrop'),
    /// *
  ///     * Remove one or more pending airdrops from state on behalf of
  ///     * the sender(s) for each airdrop.
  tokenCancelAirdrop(94, 'TokenCancelAirdrop'),
    /// *
  ///      * Claim one or more pending airdrops
  tokenClaimAirdrop(95, 'TokenClaimAirdrop'),
    /// *
  ///      * Submit a signature of a state root hash gossiped to other nodes
  stateSignatureTransaction(100, 'StateSignatureTransaction'),
    /// *
  ///      * Publish a hinTS key to the network.
  hintsKeyPublication(101, 'HintsKeyPublication'),
    /// *
  ///      * Vote for a particular preprocessing output of a hinTS construction.
  hintsPreprocessingVote(102, 'HintsPreprocessingVote'),
    /// *
  ///      * Sign a partial signature for the active hinTS construction.
  hintsPartialSignature(103, 'HintsPartialSignature'),
    /// *
  ///      * Sign a particular history assembly.
  historyAssemblySignature(104, 'HistoryAssemblySignature'),
    /// *
  ///      * Publish a roster history proof key to the network.
  historyProofKeyPublication(105, 'HistoryProofKeyPublication'),
    /// *
  ///      * Vote for a particular history proof.
  historyProofVote(106, 'HistoryProofVote'),
    /// *
  ///      * Publish a random CRS to the network.
  crsPublication(107, 'CrsPublication'),
    /// *
  ///      * Submit a batch of transactions to run atomically
  atomicBatch(108, 'AtomicBatch'),
    /// *
  ///      * (DEPRECATED) Remove once no production throttle assets reference it.
  lambdaSStore(109, 'LambdaSStore'),
    /// *
  ///      * (Internal-only) Dispatch a hook action.
  hookDispatch(110, 'HookDispatch'),
    /// *
  ///      * Update one or more storage slots in an EVM hook.
  hookStore(111, 'HookStore'),
    /// *
  ///      * (Internal-only) Publish a new ledger id and chain-of-trust key.
  ledgerIdPublication(112, 'LedgerIdPublication'),
    /// *
  ///      * Create a registered node
  registeredNodeCreate(113, 'RegisteredNodeCreate'),
    /// *
  ///      * Update a registered node
  registeredNodeUpdate(114, 'RegisteredNodeUpdate'),
    /// *
  ///      * Delete a registered node
  registeredNodeDelete(115, 'RegisteredNodeDelete'),
    /// *
  ///      * Vote on wrapped record migration hash state.
  migrationRootHashVote(116, 'MigrationRootHashVote');

  const HederaHederaFunctionality(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaHederaFunctionality fromValue(int? value) {
    value ??=0;
    return HederaHederaFunctionality.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaHederaFunctionality found for the given value. $value", details: {"name": "HederaHederaFunctionality", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaHederaFunctionality from(Object? value) {
    value ??=0;
    return HederaHederaFunctionality.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaHederaFunctionality found for the given value. $value", details: {"name": "HederaHederaFunctionality", "value": value?.toString()})
    );
  }

}


/// *
///  * # Basic Types
///  * Fundamental message types used across transactions and state as field types.
///  *
///  * ### Requirements for identifier values
///  * - Most entities in the network SHALL be identified by a multi-part
///  *   identifier. These identifier values SHALL consist of a shard, a realm, and
///  *   an entity identifier.
///  * - Shard, Realm, and Entity Number MUST all be whole numbers.
///  * - A Shard SHALL be globally unique.
///  * - A Realm MAY be reused between shards, but SHALL be unique within a shard.
///  * - An Entity Number MAY be reused between shards and realms, but SHALL be
///  *   unique within each combination of shard and realm.
///  * - Every object (e.g. account, file, token, etc...) SHALL be scoped to exactly
///  *   one realm and shard. Thus a File has a FileID, a numeric triplet, such as
///  *   0.0.2 for shard 0, realm 0, entity 2.
///  * - Identifier values SHOULD use an Entity Number as the third component of the
///  *   identifier. Some, however, MAY use alternative or composite values for the
///  *   Entity portion of the three part identifier. Any such alternative or
///  *   composite value MUST be unique within that shard and realm combination.
///  * - The entity portion of the identifier, regardless of type, MUST be unique
///  *   within that realm and shard combination and MAY be globally unique.
///  * - The triplet of shard.realm.entity MUST be globally unique, even across
///  *   different identifier types.
///  * - Each realm SHALL maintain a single counter for entity numbers, so if there
///  *   is an identifier with value 0.1.2, then there MUST NOT be an identifier
///  *   with value 0.1.2 for any other object.
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
///  * A shard identifier.&lt;br/&gt;
///  * A shard is a partition of nodes running the network that processes
///  * transactions separately from other shards. Each shard is effectively an
///  * independent instance of the overall network that shares the same virtual
///  * distributed ledger, and may gossip cross-shard transactions with other
///  * shards to maintain overall correct processing of the ledger.
class HederaShardID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard identifier.
  final BigInt? shardNum;

  const HederaShardID({
    this.shardNum,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
      ];


HederaShardID copyWith(
{BigInt? shardNum,

}) {
    return HederaShardID(
shardNum: shardNum ?? this.shardNum,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
    };
  }


  factory HederaShardID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaShardID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaShardID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaShardID(
      shardNum: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoShardID;

}


/// *
///  * A realm identifier.&lt;br/&gt;
///  * Within a given shard, every realm has a unique numeric identifier.
///  * Each account, file, and contract instance belongs to exactly one realm.
class HederaRealmID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard identifier.
  final BigInt? shardNum;

    /// *
  ///      * A whole number realm identifier.
  final BigInt? realmNum;

  const HederaRealmID({
    this.shardNum,
    this.realmNum,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
        realmNum,
      ];


HederaRealmID copyWith(
{BigInt? shardNum,

BigInt? realmNum,

}) {
    return HederaRealmID(
shardNum: shardNum ?? this.shardNum,
realmNum: realmNum ?? this.realmNum,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
      'realmNum': config.encodeBigint(realmNum),
    };
  }


  factory HederaRealmID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRealmID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
      realmNum: json.valueAsBigInt<BigInt?>('realmNum', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaRealmID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRealmID(
      shardNum: decode.getBigInt<BigInt?>(1),
      realmNum: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoRealmID;

}


/// *
///  * Unique identifier for a token.&lt;br/&gt;
///  * As with all entity identifiers within the network, a token identifier
///  * consists of a combination of shard number, realm number, and entity number.
///  * Each of these numbers is unique within its scope (shard &gt; realm &gt; entity).
class HederaTokenID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard identifier.
  final BigInt? shardNum;

    /// *
  ///      * A whole number realm identifier.
  final BigInt? realmNum;

    /// *
  ///      * A whole number token identifier.
  final BigInt? tokenNum;

  const HederaTokenID({
    this.shardNum,
    this.realmNum,
    this.tokenNum,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
        realmNum,
        tokenNum,
      ];


HederaTokenID copyWith(
{BigInt? shardNum,

BigInt? realmNum,

BigInt? tokenNum,

}) {
    return HederaTokenID(
shardNum: shardNum ?? this.shardNum,
realmNum: realmNum ?? this.realmNum,
tokenNum: tokenNum ?? this.tokenNum,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
      'realmNum': config.encodeBigint(realmNum),
      'tokenNum': config.encodeBigint(tokenNum),
    };
  }


  factory HederaTokenID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
      realmNum: json.valueAsBigInt<BigInt?>('realmNum', normalizeKeyLookup: config.normalizeKeys),
      tokenNum: json.valueAsBigInt<BigInt?>('tokenNum', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTokenID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenID(
      shardNum: decode.getBigInt<BigInt?>(1),
      realmNum: decode.getBigInt<BigInt?>(2),
      tokenNum: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenID;

}


/// *
///  * A unique identifier for an Hedera account.
///  *
///  * An account identifier is of the form `shard.realm.[number|alias]`.&lt;br/&gt;
///  * The identifier MAY use the alias form when transferring HBAR to a public key
///  * before the account for that key is created, when only the alias value is
///  * known, or in some smart contracts that use the EVM address style alias to
///  * refer to Accounts.&lt;br/&gt;
///  * When the account entry is completed, the alias SHALL be stored separately in
///  * the Account record, and the identifier in the Account SHALL use the
///  * `accountNum` form.
///  *
///  * ---
///  * ### Additional Notes
///  *
///  * #### Alias
///  * There is considerable complexity with `alias` (aka `evm_address`) for
///  * Accounts. Much of this comes from the existence of a "hidden" alias for
///  * almost all accounts, and the reuse of the alias field for both EVM reference
///  * and "automatic" account creation.&lt;br/&gt;
///  * For the purposes of this specification, we will use the following terms for
///  * clarity.
///  *   - `key_alias`&lt;br/&gt;
///  *      The account public key as a protobuf serialized message and used for
///  *      auto-creation and subsequent lookup. This is only valid if the account
///  *      key is a single `primitive` key, either Ed25519 or ECDSA_SECP256K1.
///  *   - `evm_address`&lt;br/&gt;
///  *     Exists for every account and is one of
///  *      - `contract_address`&lt;br/&gt;
///  *        The 20 byte EVM address prescribed by `CREATE` or `CREATE2`
///  *      - `evm_key_address`&lt;br/&gt;
///  *        An arbitrary 20 byte EVM address that, for a usable externally owned
///  *        account (EOA) SHALL be the rightmost 20 bytes of the Keccak-256 hash
///  *        of a ECDSA_SECP256K1 key.&lt;br/&gt;
///  *        Such accounts may be created in one of three ways:
///  *        - Sending hbar or fungible tokens to an unused
///  *          ECDSA_SECP256K1 key alias.
///  *        - Sending hbar or fungible tokens to an unassigned 20-byte
///  *          EVM address.
///  *        - Submitting a `CryptoCreate` signed with the corresponding
///  *          private key.
///  *      - `long_zero`&lt;br/&gt;
///  *        A synthetic 20 byte address inferred for "normally" created accounts.
///  *        It is constructed from the "standard" AccountID as follows.
///  *         1. 4 byte big-endian shard number
///  *         1. 8 byte big-endian realm number
///  *         1. 8 byte big-endian entity number&lt;br/&gt;
///  *
///  * The `alias` field in the `Account` message SHALL contain one of four values
///  * for any given account.
///  *   - The `key_alias`, if the account was created by transferring HBAR to the
///  *     `key_alias` public key value.
///  *   - The `evm_key_address` if the account was created from an EVM public key
///  *   - The `contract_address` if the account belongs to an EVM contract
///  *   - Not-Set/null/Bytes.EMPTY (collectively `null`) if the account was
///  *     created normally
///  *
///  * If the `alias` field of an `Account` is any form of `null`, then the account
///  * MAY be referred to by `alias` in an `AccountID` by using the `long_zero`
///  * address for the account.&lt;br/&gt;
///  * This "hidden default" alias SHALL NOT be stored, but is synthesized by the
///  * node software as needed, and may be synthesized by an EVM contract or client
///  * software as well.
///  *
///  * ---
///  *
///  * #### Alias forms
///  * An `AccountID` in a transaction MAY reference an `Account` with
///  * `shard.realm.alias`.&lt;br/&gt;
///  * If the account `alias` field is set for an Account, that value SHALL be the
///  * account alias.&lt;br/&gt;
///  * If the account `alias` field is not set for an Account, the `long_zero` alias
///  * SHALL be the account alias.
class HederaAccountID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard identifier.
  final BigInt? shardNum;

    /// *
  ///      * A whole number realm identifier.
  final BigInt? realmNum;

    /// *
  ///          * A whole number account number, unique within its realm and shard.
  ///          * &lt;p&gt;
  ///          * For any AccountID fields in the query response, transaction records,
  ///          * transaction receipts, or block stream `accountNum` MUST be used.
  final BigInt? accountNum;

    /// *
  ///          * An alias value.&lt;br/&gt;
  ///          * Alias is a value used in some contexts to refer to an account when
  ///          * account number is not available, and may be an alias public key, or
  ///          * an EVM address.
  final List<int>? alias;

  const HederaAccountID({
    this.shardNum,
    this.realmNum,
    this.accountNum,
    this.alias,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
        realmNum,
        accountNum,
        alias,
      ];


HederaAccountID copyWith(
{BigInt? shardNum,

BigInt? realmNum,

BigInt? accountNum,

List<int>? alias,

}) {
    return HederaAccountID(
shardNum: shardNum ?? this.shardNum,
realmNum: realmNum ?? this.realmNum,
accountNum: accountNum ?? this.accountNum,
alias: alias ?? this.alias,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
      'realmNum': config.encodeBigint(realmNum),
      'accountNum': config.encodeBigint(accountNum),
      'alias': config.encodeBinary(alias),
    };
  }


  factory HederaAccountID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAccountID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
      realmNum: json.valueAsBigInt<BigInt?>('realmNum', normalizeKeyLookup: config.normalizeKeys),
      accountNum: json.valueAsBigInt<BigInt?>('accountNum', normalizeKeyLookup: config.normalizeKeys),
      alias: config.decodeBinary<List<int>?>(json.valueAs('alias', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaAccountID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccountID(
      shardNum: decode.getBigInt<BigInt?>(1),
      realmNum: decode.getBigInt<BigInt?>(2),
      accountNum: decode.getBigInt<BigInt?>(3),
      alias: decode.getBytes<List<int>?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAccountID;

}


/// *
///  * An identifier for a unique token (or "NFT"), used by both contract
///  * and token services.
class HederaNftID extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.&lt;br/&gt;
  ///      * This token represents the collection containing this NFT.
  final HederaTokenID? tokenId;

    /// *
  ///      * A unique serial number.&lt;br/&gt;
  ///      * This serial number is unique within its token type.
  final BigInt? serialNumber;

  const HederaNftID({
    this.tokenId,
    this.serialNumber,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        serialNumber,
      ];


HederaNftID copyWith(
{HederaTokenID? tokenId,

BigInt? serialNumber,

}) {
    return HederaNftID(
tokenId: tokenId ?? this.tokenId,
serialNumber: serialNumber ?? this.serialNumber,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token_ID': config.encodeMessage(tokenId),
      'serial_number': config.encodeBigint(serialNumber),
    };
  }


  factory HederaNftID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNftID(
      tokenId: json.valueTo<HederaTokenID?, Object>(
        key: 'token_ID',
        parse: (v) => HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      serialNumber: json.valueAsBigInt<BigInt?>('serial_number', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaNftID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNftID(
      tokenId: decode.messageTo<HederaTokenID?>(1, (b) => HederaTokenID.deserialize(b)),
      serialNumber: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNftID;

}


/// *
///  * An identifier for a File within the network.
class HederaFileID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard identifier.
  final BigInt? shardNum;

    /// *
  ///      * A whole number realm identifier.
  final BigInt? realmNum;

    /// *
  ///      * A whole number file identifier, unique within its realm and shard.
  final BigInt? fileNum;

  const HederaFileID({
    this.shardNum,
    this.realmNum,
    this.fileNum,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
        realmNum,
        fileNum,
      ];


HederaFileID copyWith(
{BigInt? shardNum,

BigInt? realmNum,

BigInt? fileNum,

}) {
    return HederaFileID(
shardNum: shardNum ?? this.shardNum,
realmNum: realmNum ?? this.realmNum,
fileNum: fileNum ?? this.fileNum,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
      'realmNum': config.encodeBigint(realmNum),
      'fileNum': config.encodeBigint(fileNum),
    };
  }


  factory HederaFileID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFileID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
      realmNum: json.valueAsBigInt<BigInt?>('realmNum', normalizeKeyLookup: config.normalizeKeys),
      fileNum: json.valueAsBigInt<BigInt?>('fileNum', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaFileID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileID(
      shardNum: decode.getBigInt<BigInt?>(1),
      realmNum: decode.getBigInt<BigInt?>(2),
      fileNum: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFileID;

}


/// *
///  * An identifier for a smart contract within the network.
class HederaContractID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard identifier.
  final BigInt? shardNum;

    /// *
  ///      * A whole number realm identifier.
  final BigInt? realmNum;

    /// *
  ///         * A whole number contract identifier, unique within its realm and shard.
  final BigInt? contractNum;

    /// *
  ///         * A 20-byte EVM address of the contract to call.
  ///         * &lt;p&gt;
  ///         * A contract created via a HAPI `ContractCreate` call SHALL have
  ///         * an EVM address determined by its `shard.realm.num` identifier.&lt;br/&gt;
  ///         * This address is as follows
  ///         * &lt;ol&gt;
  ///         *     &lt;li&gt;4 byte big-endian shard number&lt;/li&gt;
  ///         *     &lt;li&gt;8 byte big-endian realm number&lt;/li&gt;
  ///         *     &lt;li&gt;8 byte big-endian contract number&lt;/li&gt;
  ///         * &lt;/ol&gt;
  ///         * This address is not stored in state, but is computed when needed.
  ///         * &lt;p&gt;
  ///         * Contracts created by any other means, including a HAPI
  ///         * `EthereumTransaction` whose `to` address is the zero address,
  ///         * SHALL have the EVM address prescribed by the `CREATE` or
  ///         * `CREATE2` opcode, as applicable.
  final List<int>? evmAddress;

  const HederaContractID({
    this.shardNum,
    this.realmNum,
    this.contractNum,
    this.evmAddress,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
        realmNum,
        contractNum,
        evmAddress,
      ];


HederaContractID copyWith(
{BigInt? shardNum,

BigInt? realmNum,

BigInt? contractNum,

List<int>? evmAddress,

}) {
    return HederaContractID(
shardNum: shardNum ?? this.shardNum,
realmNum: realmNum ?? this.realmNum,
contractNum: contractNum ?? this.contractNum,
evmAddress: evmAddress ?? this.evmAddress,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
      'realmNum': config.encodeBigint(realmNum),
      'contractNum': config.encodeBigint(contractNum),
      'evm_address': config.encodeBinary(evmAddress),
    };
  }


  factory HederaContractID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
      realmNum: json.valueAsBigInt<BigInt?>('realmNum', normalizeKeyLookup: config.normalizeKeys),
      contractNum: json.valueAsBigInt<BigInt?>('contractNum', normalizeKeyLookup: config.normalizeKeys),
      evmAddress: config.decodeBinary<List<int>?>(json.valueAs('evm_address', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaContractID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractID(
      shardNum: decode.getBigInt<BigInt?>(1),
      realmNum: decode.getBigInt<BigInt?>(2),
      contractNum: decode.getBigInt<BigInt?>(3),
      evmAddress: decode.getBytes<List<int>?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractID;

}


/// *
///  * An unique identifier for a topic.&lt;br/&gt;
///  * Topics are part of the consensus service, messages are published to a topic.
class HederaTopicID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard identifier.
  final BigInt? shardNum;

    /// *
  ///      * A whole number realm identifier.
  final BigInt? realmNum;

    /// *
  ///      * A whole number topic identifier, unique within its realm and shard.
  final BigInt? topicNum;

  const HederaTopicID({
    this.shardNum,
    this.realmNum,
    this.topicNum,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
        realmNum,
        topicNum,
      ];


HederaTopicID copyWith(
{BigInt? shardNum,

BigInt? realmNum,

BigInt? topicNum,

}) {
    return HederaTopicID(
shardNum: shardNum ?? this.shardNum,
realmNum: realmNum ?? this.realmNum,
topicNum: topicNum ?? this.topicNum,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
      'realmNum': config.encodeBigint(realmNum),
      'topicNum': config.encodeBigint(topicNum),
    };
  }


  factory HederaTopicID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTopicID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
      realmNum: json.valueAsBigInt<BigInt?>('realmNum', normalizeKeyLookup: config.normalizeKeys),
      topicNum: json.valueAsBigInt<BigInt?>('topicNum', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTopicID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTopicID(
      shardNum: decode.getBigInt<BigInt?>(1),
      realmNum: decode.getBigInt<BigInt?>(2),
      topicNum: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTopicID;

}


/// *
///  * An unique identifier for a Schedule
class HederaScheduleID extends HederaProtoMessage with Equality {
    /// *
  ///      * A whole number shard
  final BigInt? shardNum;

    /// *
  ///      * A whole number realm
  final BigInt? realmNum;

    /// *
  ///      * A whole number schedule, unique within its realm and shard
  final BigInt? scheduleNum;

  const HederaScheduleID({
    this.shardNum,
    this.realmNum,
    this.scheduleNum,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        shardNum,
        realmNum,
        scheduleNum,
      ];


HederaScheduleID copyWith(
{BigInt? shardNum,

BigInt? realmNum,

BigInt? scheduleNum,

}) {
    return HederaScheduleID(
shardNum: shardNum ?? this.shardNum,
realmNum: realmNum ?? this.realmNum,
scheduleNum: scheduleNum ?? this.scheduleNum,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'shardNum': config.encodeBigint(shardNum),
      'realmNum': config.encodeBigint(realmNum),
      'scheduleNum': config.encodeBigint(scheduleNum),
    };
  }


  factory HederaScheduleID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaScheduleID(
      shardNum: json.valueAsBigInt<BigInt?>('shardNum', normalizeKeyLookup: config.normalizeKeys),
      realmNum: json.valueAsBigInt<BigInt?>('realmNum', normalizeKeyLookup: config.normalizeKeys),
      scheduleNum: json.valueAsBigInt<BigInt?>('scheduleNum', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaScheduleID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleID(
      shardNum: decode.getBigInt<BigInt?>(1),
      realmNum: decode.getBigInt<BigInt?>(2),
      scheduleNum: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoScheduleID;

}


/// *
///  * A transaction identifier.&lt;br/&gt;
///  * This is used for retrieving receipts and records for a transaction
///  * and internally by the network for detecting when duplicate transactions are
///  * submitted.
///  *
///  * A transaction may be processed more reliably by submitting it to
///  * several nodes, each with a different node account, but all with the same
///  * TransactionID. Then, the transaction will take effect when the first of all
///  * those nodes submits the transaction and it reaches consensus. The other
///  * transactions SHALL NOT be executed (and SHALL result in a
///  * `DUPLICATE_TRANSACTION` response).&lt;br/&gt;
///  * Multiple submission increase reliability on the assumption that an error in,
///  * for example, network connectivity will not affect all nodes equally. Latency
///  * might be slightly lower, if one node is handling intake significantly slower
///  * than others, for example. The base transaction fee is required for each
///  * submission, however, so the total fees charged are significantly higher when
///  * using this approach.
///  *
///  * ### Requirements
///  * Each transaction identifier MUST be unique.&lt;br/&gt;
///  * Multiple transactions MAY be submitted with the same transaction
///  * identifier, but all except the first SHALL be rejected as duplicate
///  * transactions.&lt;br/&gt;
///  * An identifier MUST specify a `payer` account to be charged all fees
///  * associated with the transaction.&lt;br/&gt;
///  * The `payer` account MUST exist and MUST have sufficient HBAR to pay all
///  * transaction fees.&lt;br/&gt;
///  * An identifier MUST specify a "valid start time".&lt;br/&gt;
///  * The "valid start time" MUST be strictly _earlier_ than the current
///  * network consensus time when submitted.&lt;br/&gt;
///  * The "valid start time" MUST NOT be more than `transaction.maxValidDuration`
///  * seconds before the current network consensus time when submitted.&lt;br/&gt;
///  * A client-submitted transaction MUST NOT set the `scheduled` flag.
///  *
///  * ### Additional Notes
///  *
///  * Additional items applicable to Scheduled Transactions:
///  *
///  *  - The ID of a Scheduled Transaction, once executed, SHALL inherit both
///  *    `transactionValidStart` and `accountID` from the `ScheduleCreate`
///  *    transaction that created the schedule.
///  *  - The `scheduled` property SHALL be set for Scheduled Transactions.
class HederaTransactionID extends HederaProtoMessage with Equality {
    /// *
  ///      * A timestamp for the transaction start time.&lt;br/&gt;
  ///      * This is the earliest expected start time for this transaction.
  ///      * &lt;p&gt;
  ///      * This value MUST be strictly less than `consensusTimestamp` when the
  ///      * transaction is submitted.
  final proto_timestamp.HederaTimestamp? transactionValidStart;

    /// *
  ///      * An Account identifier.
  ///      * &lt;p&gt;
  ///      * The identified account SHALL pay transaction fees for this transaction.
  final HederaAccountID? accountID;

    /// *
  ///      * A scheduled transaction flag.&lt;br/&gt;
  ///      * If set, this transaction represents the execution of a Schedule after
  ///      * all necessary signatures are gathered.
  ///      * &lt;p&gt;
  ///      * This flag MUST NOT be set in a user-submitted transaction.
  final bool? scheduled;

    /// *
  ///      * An identifier for an internal transaction.&lt;br/&gt;
  ///      * An internal transaction is one that was spawned as part of handling a
  ///      * user transaction. These internal transactions share the
  ///      * transactionValidStart and accountID of the user transaction, so a nonce
  ///      * is necessary to give them a unique TransactionID.
  ///      * &lt;p&gt;
  ///      * An example is when a "parent" ContractCreate or ContractCall transaction
  ///      * calls one or more HTS precompiled contracts; each of the "child"
  ///      * transactions spawned for a precompile has a transaction id with a
  ///      * different nonce.
  ///      * &lt;p&gt;
  ///      * This value MUST be unset for user-submitted transactions.
  final int? nonce;

  const HederaTransactionID({
    this.transactionValidStart,
    this.accountID,
    this.scheduled,
    this.nonce,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.int32(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transactionValidStart,
        accountID,
        scheduled,
        nonce,
      ];


HederaTransactionID copyWith(
{proto_timestamp.HederaTimestamp? transactionValidStart,

HederaAccountID? accountID,

bool? scheduled,

int? nonce,

}) {
    return HederaTransactionID(
transactionValidStart: transactionValidStart ?? this.transactionValidStart,
accountID: accountID ?? this.accountID,
scheduled: scheduled ?? this.scheduled,
nonce: nonce ?? this.nonce,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transactionValidStart': config.encodeMessage(transactionValidStart),
      'accountID': config.encodeMessage(accountID),
      'scheduled': scheduled,
      'nonce': nonce,
    };
  }


  factory HederaTransactionID.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransactionID(
      transactionValidStart: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'transactionValidStart',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      accountID: json.valueTo<HederaAccountID?, Object>(
        key: 'accountID',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      scheduled: json.valueAsBool<bool?>('scheduled', normalizeKeyLookup: config.normalizeKeys),
      nonce: json.valueAsInt<int?>('nonce', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTransactionID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionID(
      transactionValidStart: decode.messageTo<proto_timestamp.HederaTimestamp?>(1, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      accountID: decode.messageTo<HederaAccountID?>(2, (b) => HederaAccountID.deserialize(b)),
      scheduled: decode.getBool<bool?>(3),
      nonce: decode.getInt<int?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTransactionID;

}


/// *
///  * Once a hook is created, its full id.
///  * &lt;p&gt;
///  * A composite of its creating entity's id and an arbitrary 64-bit hook id
///  * (which need not be sequential).
class HederaHookId extends HederaProtoMessage with Equality {
    /// *
  ///      * The hook's creating entity id.
  final HederaHookEntityId? entityId;

    /// *
  ///      * An arbitrary 64-bit identifier.
  final BigInt? hookId;

  const HederaHookId({
    this.entityId,
    this.hookId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        entityId,
        hookId,
      ];


HederaHookId copyWith(
{HederaHookEntityId? entityId,

BigInt? hookId,

}) {
    return HederaHookId(
entityId: entityId ?? this.entityId,
hookId: hookId ?? this.hookId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'entity_id': config.encodeMessage(entityId),
      'hook_id': config.encodeBigint(hookId),
    };
  }


  factory HederaHookId.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHookId(
      entityId: json.valueTo<HederaHookEntityId?, Object>(
        key: 'entity_id',
        parse: (v) => HederaHookEntityId.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      hookId: json.valueAsBigInt<BigInt?>('hook_id', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaHookId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookId(
      entityId: decode.messageTo<HederaHookEntityId?>(1, (b) => HederaHookEntityId.deserialize(b)),
      hookId: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoHookId;

}


/// *
///  * The id of an entity using a hook.
class HederaHookEntityId extends HederaProtoMessage with Equality {
    /// *
  ///          * An account using a hook.
  final HederaAccountID? accountId;

    /// *
  ///          * A contract using a hook.
  final HederaContractID? contractId;

  const HederaHookEntityId({
    this.accountId,
    this.contractId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountId,
        contractId,
      ];


HederaHookEntityId copyWith(
{HederaAccountID? accountId,

HederaContractID? contractId,

}) {
    return HederaHookEntityId(
accountId: accountId ?? this.accountId,
contractId: contractId ?? this.contractId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'account_id': config.encodeMessage(accountId),
      'contract_id': config.encodeMessage(contractId),
    };
  }


  factory HederaHookEntityId.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHookEntityId(
      accountId: json.valueTo<HederaAccountID?, Object>(
        key: 'account_id',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contractId: json.valueTo<HederaContractID?, Object>(
        key: 'contract_id',
        parse: (v) => HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaHookEntityId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookEntityId(
      accountId: decode.messageTo<HederaAccountID?>(1, (b) => HederaAccountID.deserialize(b)),
      contractId: decode.messageTo<HederaContractID?>(2, (b) => HederaContractID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoHookEntityId;

}


/// *
///  * Specifies a call to a hook from within a transaction.
///  * &lt;p&gt;
///  * Often the hook's entity is implied by the nature of the call site. For example, when using an account allowance hook
///  * inside a crypto transfer, the hook's entity is necessarily the account whose authorization is required.
///  * &lt;p&gt;
///  * For future extension points where the hook owner is not forced by the context, we include the option to fully
///  * specify the hook id for the call.
class HederaHookCall extends HederaProtoMessage with Equality {
    /// *
  ///          * The numeric id of the hook to call, when the owning entity is forced by the call site.
  final BigInt? hookId;

    /// *
  ///      * Specifies details of the call.
  /// *
  ///          * Specification of how to call an EVM hook.
  final HederaEvmHookCall? evmHookCall;

  const HederaHookCall({
    this.hookId,
    this.evmHookCall,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        hookId,
        evmHookCall,
      ];


HederaHookCall copyWith(
{BigInt? hookId,

HederaEvmHookCall? evmHookCall,

}) {
    return HederaHookCall(
hookId: hookId ?? this.hookId,
evmHookCall: evmHookCall ?? this.evmHookCall,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'hook_id': config.encodeBigint(hookId),
      'evm_hook_call': config.encodeMessage(evmHookCall),
    };
  }


  factory HederaHookCall.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHookCall(
      hookId: json.valueAsBigInt<BigInt?>('hook_id', normalizeKeyLookup: config.normalizeKeys),
      evmHookCall: json.valueTo<HederaEvmHookCall?, Object>(
        key: 'evm_hook_call',
        parse: (v) => HederaEvmHookCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaHookCall.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookCall(
      hookId: decode.getBigInt<BigInt?>(1),
      evmHookCall: decode.messageTo<HederaEvmHookCall?>(3, (b) => HederaEvmHookCall.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoHookCall;

}


/// *
///  * Specifies details of a call to an EVM hook.
class HederaEvmHookCall extends HederaProtoMessage with Equality {
    /// *
  ///      * Call data to pass to the hook via the IHieroHook.HookContext#data field.
  final List<int>? data;

    /// *
  ///      * The gas limit to use.
  final BigInt? gasLimit;

  const HederaEvmHookCall({
    this.data,
    this.gasLimit,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.uint64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        data,
        gasLimit,
      ];


HederaEvmHookCall copyWith(
{List<int>? data,

BigInt? gasLimit,

}) {
    return HederaEvmHookCall(
data: data ?? this.data,
gasLimit: gasLimit ?? this.gasLimit,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'data': config.encodeBinary(data),
      'gas_limit': config.encodeBigint(gasLimit),
    };
  }


  factory HederaEvmHookCall.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaEvmHookCall(
      data: config.decodeBinary<List<int>?>(json.valueAs('data', normalizeKeyLookup: config.normalizeKeys)),
      gasLimit: json.valueAsBigInt<BigInt?>('gas_limit', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaEvmHookCall.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookCall(
      data: decode.getBytes<List<int>?>(1),
      gasLimit: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoEvmHookCall;

}


/// *
///  * An account, and the amount that it sends or receives during a token transfer.
///  *
///  * This message is only relevant to fungible/common token transfers.
///  * Non-fungible/unique (NFT) token transfers MUST use the NftTransfer message.
class HederaAccountAmount extends HederaProtoMessage with Equality {
    /// *
  ///      * An account identifier that will send or receive token(s).
  final HederaAccountID? accountID;

    /// *
  ///      * An amount to send (negative) or receive (positive).
  ///      * &lt;p&gt;
  ///      * This amount MUST be denominated in the smallest unit of the relevant
  ///      * token.&lt;br/&gt;
  ///      * For HBAR this SHALL be tinybar (10&lt;sup&gt;-8&lt;/sup&gt; HBAR).&lt;br/&gt;
  ///      * For other fungible/common tokens this SHALL depend on the value of
  ///      * `decimals` for that token.
  final BigInt? amount;

    /// *
  ///      * An approved allowance flag.&lt;br/&gt;
  ///      * If true then the transfer is expected to be an approved allowance.
  ///      * &lt;p&gt;
  ///      * If set, `accountID` SHALL be the owner that previously approved
  ///      * the allowance.&lt;br/&gt;
  ///      * The default value SHALL be false (unset).
  final bool? isApproval;

    /// *
  ///      * If set, a call to a hook of type `ACCOUNT_ALLOWANCE_HOOK` on scoped
  ///      * account; the hook's invoked methods must not revert and must return
  ///      * true for the containing CryptoTransfer to succeed.
  ///      * &lt;p&gt;
  ///      * Cannot be set if `is_approval` is true.
  /// *
  ///          * A single call made before attempting the CryptoTransfer, to a
  ///          * method with logical signature allow(HookContext, ProposedTransfers)
  final HederaHookCall? preTxAllowanceHook;

    /// *
  ///          * Two calls, the first call before attempting the CryptoTransfer, to a
  ///          * method with logical signature allowPre(HookContext, ProposedTransfers);
  ///          * and the second call after attempting the CryptoTransfer, to a method
  ///          * with logical signature allowPost(HookContext, ProposedTransfers).
  final HederaHookCall? prePostTxAllowanceHook;

  const HederaAccountAmount({
    this.accountID,
    this.amount,
    this.isApproval,
    this.preTxAllowanceHook,
    this.prePostTxAllowanceHook,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.sint64(2),
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountID,
        amount,
        isApproval,
        preTxAllowanceHook,
        prePostTxAllowanceHook,
      ];


HederaAccountAmount copyWith(
{HederaAccountID? accountID,

BigInt? amount,

bool? isApproval,

HederaHookCall? preTxAllowanceHook,

HederaHookCall? prePostTxAllowanceHook,

}) {
    return HederaAccountAmount(
accountID: accountID ?? this.accountID,
amount: amount ?? this.amount,
isApproval: isApproval ?? this.isApproval,
preTxAllowanceHook: preTxAllowanceHook ?? this.preTxAllowanceHook,
prePostTxAllowanceHook: prePostTxAllowanceHook ?? this.prePostTxAllowanceHook,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'accountID': config.encodeMessage(accountID),
      'amount': config.encodeBigint(amount),
      'is_approval': isApproval,
      'pre_tx_allowance_hook': config.encodeMessage(preTxAllowanceHook),
      'pre_post_tx_allowance_hook': config.encodeMessage(prePostTxAllowanceHook),
    };
  }


  factory HederaAccountAmount.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAccountAmount(
      accountID: json.valueTo<HederaAccountID?, Object>(
        key: 'accountID',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
      isApproval: json.valueAsBool<bool?>('is_approval', normalizeKeyLookup: config.normalizeKeys),
      preTxAllowanceHook: json.valueTo<HederaHookCall?, Object>(
        key: 'pre_tx_allowance_hook',
        parse: (v) => HederaHookCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      prePostTxAllowanceHook: json.valueTo<HederaHookCall?, Object>(
        key: 'pre_post_tx_allowance_hook',
        parse: (v) => HederaHookCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaAccountAmount.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccountAmount(
      accountID: decode.messageTo<HederaAccountID?>(1, (b) => HederaAccountID.deserialize(b)),
      amount: decode.getBigInt<BigInt?>(2),
      isApproval: decode.getBool<bool?>(3),
      preTxAllowanceHook: decode.messageTo<HederaHookCall?>(4, (b) => HederaHookCall.deserialize(b)),
      prePostTxAllowanceHook: decode.messageTo<HederaHookCall?>(5, (b) => HederaHookCall.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAccountAmount;

}


/// *
///  * A list of accounts and amounts to transfer.
///  *
///  * Each `AccountAmount` SHALL specify the account and the amount to
///  * send(negative) or receive(positive).&lt;br/&gt;
///  * Each `TransferList` SHALL be contained in another message that contains
///  * other details required to complete a transfer. This is typically a
///  * `CryptoTransferTransactionBody` or `TransactionRecord`.&lt;br/&gt;
///  * The `TransferList` SHALL only be used for HBAR transfers. Other token types
///  * MUST use the `TokenTransferList` message.
class HederaTransferList extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of AccountAmount pairs.&lt;br/&gt;
  ///      * Each entry in this list is an account and an amount to transfer
  ///      * into it (positive) or out of it (negative)
  final List<HederaAccountAmount> accountAmounts;

  const HederaTransferList({
    this.accountAmounts = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountAmounts,
      ];


HederaTransferList copyWith(
{List<HederaAccountAmount>? accountAmounts,

}) {
    return HederaTransferList(
accountAmounts: accountAmounts ?? this.accountAmounts,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'accountAmounts': accountAmounts.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTransferList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransferList(
      accountAmounts: (json.valueEnsureAsList<dynamic>('accountAmounts', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaAccountAmount, Object>(
          value: e,
          parse: (v) => HederaAccountAmount.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTransferList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransferList(
      accountAmounts: decode.getListOfBytes(1).map((b) => HederaAccountAmount.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTransferList;

}


/// *
///  * A NFT transfer.&lt;br/&gt;
///  * This refers to a sender account, a receiver account, and the serial number
///  * of an NFT to transfer from sender to receiver.
///  *
///  * Each `NftTransfer` SHALL be contained in another message (typically
///  * `TokenTransferList`) that details which `Token` type applies to this NFT
///  * transfer.
class HederaNftTransfer extends HederaProtoMessage with Equality {
    /// *
  ///      * An Account identifier for the sender.
  final HederaAccountID? senderAccountID;

    /// *
  ///      * An Account identifier for the receiver.
  final HederaAccountID? receiverAccountID;

    /// *
  ///      * A serial number for the NFT to transfer.
  final BigInt? serialNumber;

    /// *
  ///      * An approved allowance flag.&lt;br/&gt;
  ///      * If true then the transfer is expected to be an approved allowance.
  ///      * &lt;p&gt;
  ///      * If set, `senderAccountID` SHALL be the owner that previously approved
  ///      * the allowance.&lt;br/&gt;
  ///      * If set, the `senderAccountID` MUST be the "payer" account for
  ///      * the transaction &lt;br/&gt;
  ///      * The default value SHALL be false (unset).
  final bool? isApproval;

    /// *
  ///      * If set, a call to a hook of type `ACCOUNT_ALLOWANCE_HOOK` installed on
  ///      * senderAccountID that must succeed for the transaction to occur.
  ///      * &lt;p&gt;
  ///      * Cannot be set if `is_approval` is true.
  /// *
  ///          * A single call made before attempting the CryptoTransfer, to a
  ///          * method with logical signature allow(HookContext, ProposedTransfers)
  final HederaHookCall? preTxSenderAllowanceHook;

    /// *
  ///          * Two calls, the first call before attempting the CryptoTransfer, to a
  ///          * method with logical signature allowPre(HookContext, ProposedTransfers);
  ///          * and the second call after attempting the CryptoTransfer, to a method
  ///          * with logical signature allowPost(HookContext, ProposedTransfers).
  final HederaHookCall? prePostTxSenderAllowanceHook;

    /// *
  ///      * If set, a call to a hook of type `ACCOUNT_ALLOWANCE_HOOK` installed on
  ///      * receiverAccountID that must succeed for the transaction to occur.
  ///      * &lt;p&gt;
  ///      * May be set even if `is_approval` is true. In this case, the approval applies
  ///      * to the sender authorization, and the hook applies to the receiver authorization
  ///      * (if needed, e.g. because of a fallback royalty fee or receiver signature
  ///      * requirement).
  /// *
  ///          * A single call made before attempting the CryptoTransfer, to a
  ///          * method with logical signature allow(HookContext, ProposedTransfers)
  final HederaHookCall? preTxReceiverAllowanceHook;

    /// *
  ///          * Two calls, the first call before attempting the CryptoTransfer, to a
  ///          * method with logical signature allowPre(HookContext, ProposedTransfers);
  ///          * and the second call after attempting the CryptoTransfer, to a method
  ///          * with logical signature allowPost(HookContext, ProposedTransfers).
  final HederaHookCall? prePostTxReceiverAllowanceHook;

  const HederaNftTransfer({
    this.senderAccountID,
    this.receiverAccountID,
    this.serialNumber,
    this.isApproval,
    this.preTxSenderAllowanceHook,
    this.prePostTxSenderAllowanceHook,
    this.preTxReceiverAllowanceHook,
    this.prePostTxReceiverAllowanceHook,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        senderAccountID,
        receiverAccountID,
        serialNumber,
        isApproval,
        preTxSenderAllowanceHook,
        prePostTxSenderAllowanceHook,
        preTxReceiverAllowanceHook,
        prePostTxReceiverAllowanceHook,
      ];


HederaNftTransfer copyWith(
{HederaAccountID? senderAccountID,

HederaAccountID? receiverAccountID,

BigInt? serialNumber,

bool? isApproval,

HederaHookCall? preTxSenderAllowanceHook,

HederaHookCall? prePostTxSenderAllowanceHook,

HederaHookCall? preTxReceiverAllowanceHook,

HederaHookCall? prePostTxReceiverAllowanceHook,

}) {
    return HederaNftTransfer(
senderAccountID: senderAccountID ?? this.senderAccountID,
receiverAccountID: receiverAccountID ?? this.receiverAccountID,
serialNumber: serialNumber ?? this.serialNumber,
isApproval: isApproval ?? this.isApproval,
preTxSenderAllowanceHook: preTxSenderAllowanceHook ?? this.preTxSenderAllowanceHook,
prePostTxSenderAllowanceHook: prePostTxSenderAllowanceHook ?? this.prePostTxSenderAllowanceHook,
preTxReceiverAllowanceHook: preTxReceiverAllowanceHook ?? this.preTxReceiverAllowanceHook,
prePostTxReceiverAllowanceHook: prePostTxReceiverAllowanceHook ?? this.prePostTxReceiverAllowanceHook,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'senderAccountID': config.encodeMessage(senderAccountID),
      'receiverAccountID': config.encodeMessage(receiverAccountID),
      'serialNumber': config.encodeBigint(serialNumber),
      'is_approval': isApproval,
      'pre_tx_sender_allowance_hook': config.encodeMessage(preTxSenderAllowanceHook),
      'pre_post_tx_sender_allowance_hook': config.encodeMessage(prePostTxSenderAllowanceHook),
      'pre_tx_receiver_allowance_hook': config.encodeMessage(preTxReceiverAllowanceHook),
      'pre_post_tx_receiver_allowance_hook': config.encodeMessage(prePostTxReceiverAllowanceHook),
    };
  }


  factory HederaNftTransfer.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNftTransfer(
      senderAccountID: json.valueTo<HederaAccountID?, Object>(
        key: 'senderAccountID',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      receiverAccountID: json.valueTo<HederaAccountID?, Object>(
        key: 'receiverAccountID',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      serialNumber: json.valueAsBigInt<BigInt?>('serialNumber', normalizeKeyLookup: config.normalizeKeys),
      isApproval: json.valueAsBool<bool?>('is_approval', normalizeKeyLookup: config.normalizeKeys),
      preTxSenderAllowanceHook: json.valueTo<HederaHookCall?, Object>(
        key: 'pre_tx_sender_allowance_hook',
        parse: (v) => HederaHookCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      prePostTxSenderAllowanceHook: json.valueTo<HederaHookCall?, Object>(
        key: 'pre_post_tx_sender_allowance_hook',
        parse: (v) => HederaHookCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      preTxReceiverAllowanceHook: json.valueTo<HederaHookCall?, Object>(
        key: 'pre_tx_receiver_allowance_hook',
        parse: (v) => HederaHookCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      prePostTxReceiverAllowanceHook: json.valueTo<HederaHookCall?, Object>(
        key: 'pre_post_tx_receiver_allowance_hook',
        parse: (v) => HederaHookCall.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaNftTransfer.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNftTransfer(
      senderAccountID: decode.messageTo<HederaAccountID?>(1, (b) => HederaAccountID.deserialize(b)),
      receiverAccountID: decode.messageTo<HederaAccountID?>(2, (b) => HederaAccountID.deserialize(b)),
      serialNumber: decode.getBigInt<BigInt?>(3),
      isApproval: decode.getBool<bool?>(4),
      preTxSenderAllowanceHook: decode.messageTo<HederaHookCall?>(5, (b) => HederaHookCall.deserialize(b)),
      prePostTxSenderAllowanceHook: decode.messageTo<HederaHookCall?>(6, (b) => HederaHookCall.deserialize(b)),
      preTxReceiverAllowanceHook: decode.messageTo<HederaHookCall?>(7, (b) => HederaHookCall.deserialize(b)),
      prePostTxReceiverAllowanceHook: decode.messageTo<HederaHookCall?>(8, (b) => HederaHookCall.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNftTransfer;

}


/// *
///  * A list of transfers for a particular (non-HBAR) token type.
///  *
///  * A `TokenTransferList` applies to a single token type, but may contain many
///  * individual transfers.&lt;br/&gt;
///  * Each transfer of a fungible/common token MUST specify an `accountID` and
///  * `amount`. Amount SHALL be positive when the account receives tokens, and
///  * SHALL be negative when the account sends tokens. The amount SHOULD NOT be
///  * `0`.&lt;br/&gt;
///  * In a transfer list containing fungible/common tokens in the `transfers`
///  * list, the sum of all such transfers MUST be zero (`0`).
///  * Each transfer of a unique token SHALL specify both sender and receiver, as
///  * well as the serial number transferred.&lt;br/&gt;
///  * A single `TokenTransferList` MUST contain `transfers` or `nftTransfers`,
///  * but MUST NOT contain both.
class HederaTokenTransferList extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.&lt;br/&gt;
  ///      * This is the token to be transferred.
  final HederaTokenID? token;

    /// *
  ///      * A list of account amounts.
  ///      * &lt;p&gt;
  ///      * Each entry SHALL have an account and amount.&lt;br/&gt;
  ///      * These transfers SHALL be "double-entry" style; the credits (positive
  ///      * amount) and debits (negative amount) MUST sum to 0, unless this
  ///      * transfer list is part of a `mint` or `burn` operation.&lt;br/&gt;
  ///      * This SHALL be be set for fungible/common tokens and MUST be
  ///      * empty otherwise.
  final List<HederaAccountAmount> transfers;

    /// *
  ///      * A list of NftTransfers.
  ///      * &lt;p&gt;
  ///      * Each entry SHALL have a sender and receiver account, and the
  ///      * serial number of the unique token to transfer.&lt;br/&gt;
  ///      * This SHALL be be set for non-fungible/unique tokens and SHALL be
  ///      * empty otherwise.
  final List<HederaNftTransfer> nftTransfers;

    /// *
  ///      * An expected decimal precision.&lt;br/&gt;
  ///      * This is the number of decimals a fungible/common token type is
  ///      * _expected_ to have.
  ///      * &lt;p&gt;
  ///      * The transfer SHALL fail with response code `UNEXPECTED_TOKEN_DECIMALS`
  ///      * if this is set and the actual decimals specified for the `Token` differ
  ///      * from this value.&lt;br/&gt;
  ///      * If `nftTransfers` is set, then this value SHOULD NOT be set.
  final google_protobuf_wrappers.HederaUInt32Value? expectedDecimals;

  const HederaTokenTransferList({
    this.token,
    this.transfers = const [],
    this.nftTransfers = const [],
    this.expectedDecimals,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        token,
        transfers,
        nftTransfers,
        expectedDecimals,
      ];


HederaTokenTransferList copyWith(
{HederaTokenID? token,

List<HederaAccountAmount>? transfers,

List<HederaNftTransfer>? nftTransfers,

google_protobuf_wrappers.HederaUInt32Value? expectedDecimals,

}) {
    return HederaTokenTransferList(
token: token ?? this.token,
transfers: transfers ?? this.transfers,
nftTransfers: nftTransfers ?? this.nftTransfers,
expectedDecimals: expectedDecimals ?? this.expectedDecimals,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token': config.encodeMessage(token),
      'transfers': transfers.map((e) => config.encodeMessage(e)).toList(),
      'nftTransfers': nftTransfers.map((e) => config.encodeMessage(e)).toList(),
      'expected_decimals': config.encodeMessage(expectedDecimals),
    };
  }


  factory HederaTokenTransferList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenTransferList(
      token: json.valueTo<HederaTokenID?, Object>(
        key: 'token',
        parse: (v) => HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transfers: (json.valueEnsureAsList<dynamic>('transfers', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaAccountAmount, Object>(
          value: e,
          parse: (v) => HederaAccountAmount.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      nftTransfers: (json.valueEnsureAsList<dynamic>('nftTransfers', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaNftTransfer, Object>(
          value: e,
          parse: (v) => HederaNftTransfer.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      expectedDecimals: json.valueTo<google_protobuf_wrappers.HederaUInt32Value?, Object>(
        key: 'expected_decimals',
        parse: (v) => google_protobuf_wrappers.HederaUInt32Value.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaTokenTransferList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenTransferList(
      token: decode.messageTo<HederaTokenID?>(1, (b) => HederaTokenID.deserialize(b)),
      transfers: decode.getListOfBytes(2).map((b) => HederaAccountAmount.deserialize(b)).toList(),
      nftTransfers: decode.getListOfBytes(3).map((b) => HederaNftTransfer.deserialize(b)).toList(),
      expectedDecimals: decode.messageTo<google_protobuf_wrappers.HederaUInt32Value?>(4, (b) => google_protobuf_wrappers.HederaUInt32Value.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenTransferList;

}


/// *
///  * A rational number.&lt;br/&gt;
///  * A common use is to set the amount of a value transfer to collect as a
///  * custom fee.
///  *
///  * It is RECOMMENDED that both numerator and denominator be no larger than
///  * necessary to express the required fraction. A very large numerator, in
///  * particular, may not be reliable.
///  * Both fields are REQUIRED and SHOULD be positive integers.
class HederaFraction extends HederaProtoMessage with Equality {
    /// *
  ///      * A fractional number's numerator.
  final BigInt? numerator;

    /// *
  ///      * A fractional number's denominator.
  ///      * &lt;p&gt;
  ///      * A zero value SHALL fail with response code `FRACTION_DIVIDES_BY_ZERO`.
  final BigInt? denominator;

  const HederaFraction({
    this.numerator,
    this.denominator,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        numerator,
        denominator,
      ];


HederaFraction copyWith(
{BigInt? numerator,

BigInt? denominator,

}) {
    return HederaFraction(
numerator: numerator ?? this.numerator,
denominator: denominator ?? this.denominator,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'numerator': config.encodeBigint(numerator),
      'denominator': config.encodeBigint(denominator),
    };
  }


  factory HederaFraction.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFraction(
      numerator: json.valueAsBigInt<BigInt?>('numerator', normalizeKeyLookup: config.normalizeKeys),
      denominator: json.valueAsBigInt<BigInt?>('denominator', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaFraction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFraction(
      numerator: decode.getBigInt<BigInt?>(1),
      denominator: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFraction;

}


/// *
///  * A Key is an entity representing one or more cryptographic public/private key
///  * pairs and, optionally, the structure for how multiple signatures may be
///  * composed to meet complex multiple-signature authorization requirements.
///  *
///  * A Key can be a public key from either the Ed25519 or ECDSA(secp256k1)
///  * signature schemes. In the ECDSA(secp256k1) case we require the 33-byte
///  * compressed form of the public key. For simplicity, we call these
///  * cryptographic public keys `primitive` keys.&lt;br/&gt;
///  * If an entity has a primitive key associated to it, then the corresponding
///  * private key must sign any transaction to send tokens or perform other
///  * actions requiring authorization.
///  *
///  * A Key can also be the ID of a smart contract, which SHALL authorize that
///  * contract to execute any system contract with signing requirements that are
///  * met by the key.&lt;br/&gt;
///  * &gt; Example
///  * &gt;&gt; If account `0.0.A` has a threshold key whose threshold is satisfied
///  * &gt;&gt; by a contract ID key for contract `0.0.C`, then when `0.0.C` is called,
///  * &gt;&gt; it is authorized to use system contracts to manage any asset owned by
///  * &gt;&gt; `0.0.A`. If the contract ID key is "delegatable", then `0.0.C` can even
///  * &gt;&gt; perform these actions when running code accessed via `DELEGATECALL`.
///  *
///  * A Key can be a "threshold key", which is a list of N keys, any M of which
///  * may sign in order for the signature to be considered valid. The value of
///  * M for a given threshold key MUST be less than or equal to N. A threshold
///  * key is sometimes called a "M-of-N" key.
///  *
///  * A Key can be a "key list" where all keys in the list must sign unless
///  * specified otherwise in the documentation for a specific transaction
///  * type (e.g. FileDeleteTransactionBody).&lt;br/&gt;
///  * This implies that the use of a key list is dependent on context. For
///  * example, an Hedera file that is created with a list of keys, SHALL require
///  * that all of those keys must sign a transaction to create or modify the file,
///  * but only one key from that list MUST sign a transaction to delete the file.
///  * So it is a single list that sometimes acts as a N-of-N threshold key, and
///  * sometimes acts as a 1-of-N threshold key.&lt;br/&gt;
///  * To reduce confusion this may cause, a key list SHALL always be considered
///  * N-of-N, unless specified otherwise in official documentation.&lt;br/&gt;
///  * A key list MAY have repeated primitive public keys, but the signature
///  * requirement for all keys in a repeated set SHALL be satisfied by a single
///  * valid signature. There is no mechanism to require a single key to sign a
///  * single transaction more than once.
///  *
///  * Any list or threshold key MAY have nested key lists or threshold keys.
///  * This allows, for example, the keys within a threshold signature to
///  * themselves be threshold, list, contract, or primitive keys. This nesting
///  * structure enables complex asymmetric multi-party signature requirements to
///  * be met.
///  *
///  * To ensure adequate performance and transaction security, key nesting is
///  * limited to at most fifteen(15) levels.
class HederaKey extends HederaProtoMessage with Equality {
    /// *
  ///          * A smart contract instance that is authorized implicitly.
  ///          * &lt;p&gt;
  ///          * This key type SHALL require that the code in the active message frame
  ///          * belong to the contract with the given id.
  final HederaContractID? contractID;

    /// *
  ///          * An array of Ed25519 public key bytes.
  final List<int>? ed25519;

    /// *
  ///          * This option is not currently supported.&lt;br/&gt;
  ///          * An array of RSA-3072 public key bytes.
  final List<int>? rsa3072;

    /// *
  ///          * This option is not currently supported.&lt;br/&gt;
  ///          * An array of ECDSA, using the p-384 curve, public key bytes.
  final List<int>? ecdsa384;

    /// *
  ///          * A threshold, M, combined with a list of N keys, any M of which are
  ///          * sufficient to form a valid signature.
  final HederaThresholdKey? thresholdKey;

    /// *
  ///          * A list of keys. This may be treated like a "N-of-N" threshold key,
  ///          * as a component of another key, or in some other manner as documented.
  final HederaKeyList? keyList;

    /// *
  ///          * A set of compressed ECDSA(secp256k1) public key bytes.&lt;br/&gt;
  ///          * This is an EVM compatibility format.
  final List<int>? ecdsaSecp256k1;

    /// *
  ///          * A smart contract that, if the recipient of the active message frame,
  ///          * SHALL be imputed authorization.&lt;br/&gt;
  ///          * Setting this key type is a more permissive version of setting a
  ///          * contractID key.
  ///          * &lt;p&gt;
  ///          * This key form SHALL NOT strictly require that the code being executed
  ///          * in the frame belong to the given contract. The code in frame MAY be
  ///          * running another contract via a `delegatecall`.
  final HederaContractID? delegatableContractId;

  const HederaKey({
    this.contractID,
    this.ed25519,
    this.rsa3072,
    this.ecdsa384,
    this.thresholdKey,
    this.keyList,
    this.ecdsaSecp256k1,
    this.delegatableContractId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.bytes(4, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.message(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        contractID,
        ed25519,
        rsa3072,
        ecdsa384,
        thresholdKey,
        keyList,
        ecdsaSecp256k1,
        delegatableContractId,
      ];


HederaKey copyWith(
{HederaContractID? contractID,

List<int>? ed25519,

List<int>? rsa3072,

List<int>? ecdsa384,

HederaThresholdKey? thresholdKey,

HederaKeyList? keyList,

List<int>? ecdsaSecp256k1,

HederaContractID? delegatableContractId,

}) {
    return HederaKey(
contractID: contractID ?? this.contractID,
ed25519: ed25519 ?? this.ed25519,
rsa3072: rsa3072 ?? this.rsa3072,
ecdsa384: ecdsa384 ?? this.ecdsa384,
thresholdKey: thresholdKey ?? this.thresholdKey,
keyList: keyList ?? this.keyList,
ecdsaSecp256k1: ecdsaSecp256k1 ?? this.ecdsaSecp256k1,
delegatableContractId: delegatableContractId ?? this.delegatableContractId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contractID': config.encodeMessage(contractID),
      'ed25519': config.encodeBinary(ed25519),
      'RSA_3072': config.encodeBinary(rsa3072),
      'ECDSA_384': config.encodeBinary(ecdsa384),
      'thresholdKey': config.encodeMessage(thresholdKey),
      'keyList': config.encodeMessage(keyList),
      'ECDSA_secp256k1': config.encodeBinary(ecdsaSecp256k1),
      'delegatable_contract_id': config.encodeMessage(delegatableContractId),
    };
  }


  factory HederaKey.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaKey(
      contractID: json.valueTo<HederaContractID?, Object>(
        key: 'contractID',
        parse: (v) => HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      ed25519: config.decodeBinary<List<int>?>(json.valueAs('ed25519', normalizeKeyLookup: config.normalizeKeys)),
      rsa3072: config.decodeBinary<List<int>?>(json.valueAs('RSA_3072', normalizeKeyLookup: config.normalizeKeys)),
      ecdsa384: config.decodeBinary<List<int>?>(json.valueAs('ECDSA_384', normalizeKeyLookup: config.normalizeKeys)),
      thresholdKey: json.valueTo<HederaThresholdKey?, Object>(
        key: 'thresholdKey',
        parse: (v) => HederaThresholdKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      keyList: json.valueTo<HederaKeyList?, Object>(
        key: 'keyList',
        parse: (v) => HederaKeyList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      ecdsaSecp256k1: config.decodeBinary<List<int>?>(json.valueAs('ECDSA_secp256k1', normalizeKeyLookup: config.normalizeKeys)),
      delegatableContractId: json.valueTo<HederaContractID?, Object>(
        key: 'delegatable_contract_id',
        parse: (v) => HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaKey(
      contractID: decode.messageTo<HederaContractID?>(1, (b) => HederaContractID.deserialize(b)),
      ed25519: decode.getBytes<List<int>?>(2),
      rsa3072: decode.getBytes<List<int>?>(3),
      ecdsa384: decode.getBytes<List<int>?>(4),
      thresholdKey: decode.messageTo<HederaThresholdKey?>(5, (b) => HederaThresholdKey.deserialize(b)),
      keyList: decode.messageTo<HederaKeyList?>(6, (b) => HederaKeyList.deserialize(b)),
      ecdsaSecp256k1: decode.getBytes<List<int>?>(7),
      delegatableContractId: decode.messageTo<HederaContractID?>(8, (b) => HederaContractID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoKey;

}


/// *
///  * A threshold value and a list of public keys that, together, form a threshold
///  * signature requirement. Any subset of the keys in the list may satisfy the
///  * signature requirements of this type of key, provided the number of keys meets
///  * or exceeds the threshold. For example, if a particular key has a threshold of
///  * three(3) and eight(8) keys in the list, then any three(3) signatures, from
///  * the list of eight(8), is sufficient to authorize that key.
///  *
///  * For threshold purposes, all signatures from a single `primitive` key are
///  * considered a single signature, so that signature(s) from a single key SHALL
///  * NOT _directly_ meet a threshold greater than one(1).
///  *
///  * #### Note
///  * &gt; It is possible to construct a complex key structure that _would_ enable a
///  * &gt; single primitive key to successfully meet a threshold requirement. All
///  * &gt; threshold keys SHOULD be carefully audited to ensure no one `primitive`
///  * &gt; key, or smart contract, has disproportionate capability.
class HederaThresholdKey extends HederaProtoMessage with Equality {
    /// *
  ///      * A transaction MUST have valid signatures from at least this number of
  ///      * separate keys, from the `keys` list to be authorized by this key.
  final int? threshold;

    /// *
  ///      * A list of the keys that MAY satisfy signature requirements of this key.
  final HederaKeyList? keys;

  const HederaThresholdKey({
    this.threshold,
    this.keys,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        threshold,
        keys,
      ];


HederaThresholdKey copyWith(
{int? threshold,

HederaKeyList? keys,

}) {
    return HederaThresholdKey(
threshold: threshold ?? this.threshold,
keys: keys ?? this.keys,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'threshold': threshold,
      'keys': config.encodeMessage(keys),
    };
  }


  factory HederaThresholdKey.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaThresholdKey(
      threshold: json.valueAsInt<int?>('threshold', normalizeKeyLookup: config.normalizeKeys),
      keys: json.valueTo<HederaKeyList?, Object>(
        key: 'keys',
        parse: (v) => HederaKeyList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaThresholdKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaThresholdKey(
      threshold: decode.getInt<int?>(1),
      keys: decode.messageTo<HederaKeyList?>(2, (b) => HederaKeyList.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoThresholdKey;

}


/// *
///  * A list of keys.&lt;br/&gt;
///  * A `KeyList` requires all keys (N-of-N) to sign, unless otherwise
///  * specified in official documentation. A KeyList may contain repeated keys,
///  * but all such repeated keys are considered a single key when determining
///  * signature authorization.
///  *
///  * ### Additional Notes
///  * 1. An empty key list is the "standard" mechanism to represent an
///  *    unassigned key. For example, if the `admin_key` of a token is set
///  *    to the empty key list, then that token has no admin key, and
///  *    functionality that requires an admin key to sign the
///  *    transaction is disabled.
class HederaKeyList extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of keys. All values in this list SHALL be non-null.
  ///      * &lt;p&gt;
  final List<HederaKey> keys;

  const HederaKeyList({
    this.keys = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        keys,
      ];


HederaKeyList copyWith(
{List<HederaKey>? keys,

}) {
    return HederaKeyList(
keys: keys ?? this.keys,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'keys': keys.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaKeyList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaKeyList(
      keys: (json.valueEnsureAsList<dynamic>('keys', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaKey, Object>(
          value: e,
          parse: (v) => HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaKeyList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaKeyList(
      keys: decode.getListOfBytes(1).map((b) => HederaKey.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoKeyList;

}


/// *
///  * This message is deprecated and MUST NOT be used to communicate with
///  * network nodes. It is retained here only for historical reasons.
///  *
///  * Client software MUST NOT include this message in any request. &lt;br/&gt;
///  * Compliant nodes SHALL NOT accept any request containing this message.
///  *
///  * Please use the `SignaturePair` and `SignatureMap` messages instead of
///  * this message.
class HederaSignature extends HederaProtoMessage with Equality {
    /// *
  ///          * Smart contract virtual signature (always length zero).
  final List<int>? contract;

    /// *
  ///          * Ed25519 signature bytes.
  final List<int>? ed25519;

    /// *
  ///          * RSA-3072 signature bytes.
  final List<int>? rsa3072;

    /// *
  ///          * ECDSA p-384 signature bytes.
  final List<int>? ecdsa384;

    /// *
  ///          * A list of signatures for a single N-of-M threshold Key. This must be
  ///          * a list of exactly M signatures, at least N of which are non-null.
  final HederaThresholdSignature? thresholdSignature;

    /// *
  ///          * A list of M signatures, each corresponding to a Key in a KeyList
  ///          * of the same length.
  final HederaSignatureList? signatureList;

  const HederaSignature({
    this.contract,
    this.ed25519,
    this.rsa3072,
    this.ecdsa384,
    this.thresholdSignature,
    this.signatureList,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        contract,
        ed25519,
        rsa3072,
        ecdsa384,
        thresholdSignature,
        signatureList,
      ];


HederaSignature copyWith(
{List<int>? contract,

List<int>? ed25519,

List<int>? rsa3072,

List<int>? ecdsa384,

HederaThresholdSignature? thresholdSignature,

HederaSignatureList? signatureList,

}) {
    return HederaSignature(
contract: contract ?? this.contract,
ed25519: ed25519 ?? this.ed25519,
rsa3072: rsa3072 ?? this.rsa3072,
ecdsa384: ecdsa384 ?? this.ecdsa384,
thresholdSignature: thresholdSignature ?? this.thresholdSignature,
signatureList: signatureList ?? this.signatureList,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contract': config.encodeBinary(contract),
      'ed25519': config.encodeBinary(ed25519),
      'RSA_3072': config.encodeBinary(rsa3072),
      'ECDSA_384': config.encodeBinary(ecdsa384),
      'thresholdSignature': config.encodeMessage(thresholdSignature),
      'signatureList': config.encodeMessage(signatureList),
    };
  }


  factory HederaSignature.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSignature(
      contract: config.decodeBinary<List<int>?>(json.valueAs('contract', normalizeKeyLookup: config.normalizeKeys)),
      ed25519: config.decodeBinary<List<int>?>(json.valueAs('ed25519', normalizeKeyLookup: config.normalizeKeys)),
      rsa3072: config.decodeBinary<List<int>?>(json.valueAs('RSA_3072', normalizeKeyLookup: config.normalizeKeys)),
      ecdsa384: config.decodeBinary<List<int>?>(json.valueAs('ECDSA_384', normalizeKeyLookup: config.normalizeKeys)),
      thresholdSignature: json.valueTo<HederaThresholdSignature?, Object>(
        key: 'thresholdSignature',
        parse: (v) => HederaThresholdSignature.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      signatureList: json.valueTo<HederaSignatureList?, Object>(
        key: 'signatureList',
        parse: (v) => HederaSignatureList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaSignature.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignature(
      contract: decode.getBytes<List<int>?>(1),
      ed25519: decode.getBytes<List<int>?>(2),
      rsa3072: decode.getBytes<List<int>?>(3),
      ecdsa384: decode.getBytes<List<int>?>(4),
      thresholdSignature: decode.messageTo<HederaThresholdSignature?>(5, (b) => HederaThresholdSignature.deserialize(b)),
      signatureList: decode.messageTo<HederaSignatureList?>(6, (b) => HederaSignatureList.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSignature;

}


/// *
///  * This message is deprecated and MUST NOT be used to communicate with network
///  * nodes. It is retained here only for historical reasons.
///  *
///  * Client software MUST NOT include this message in any request. &lt;br/&gt;
///  * Compliant nodes SHALL NOT accept any request containing this message.
///  *
///  * Please use the `SignaturePair` and `SignatureMap` messages, in combination
///  * with `ThresholdKey` keys, instead of this message.
class HederaThresholdSignature extends HederaProtoMessage with Equality {
    /// *
  ///      * For an N-of-M threshold key, this is a list of M signatures, at least N
  ///      * of which must be non-null.
  final HederaSignatureList? sigs;

  const HederaThresholdSignature({
    this.sigs,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sigs,
      ];


HederaThresholdSignature copyWith(
{HederaSignatureList? sigs,

}) {
    return HederaThresholdSignature(
sigs: sigs ?? this.sigs,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sigs': config.encodeMessage(sigs),
    };
  }


  factory HederaThresholdSignature.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaThresholdSignature(
      sigs: json.valueTo<HederaSignatureList?, Object>(
        key: 'sigs',
        parse: (v) => HederaSignatureList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaThresholdSignature.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaThresholdSignature(
      sigs: decode.messageTo<HederaSignatureList?>(2, (b) => HederaSignatureList.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoThresholdSignature;

}


/// *
///  * This message is deprecated and MUST NOT be used to communicate with network
///  * nodes. It is retained here only for historical reasons.
///  *
///  * Client software MUST NOT include this message in any request. &lt;br/&gt;
///  * Compliant nodes SHALL NOT accept any request containing this message.
///  *
///  * Please use the `SignaturePair` and `SignatureMap` messages instead of
///  * this message.
class HederaSignatureList extends HederaProtoMessage with Equality {
    /// *
  ///      * Each signature corresponds to a Key in the KeyList.
  final List<HederaSignature> sigs;

  const HederaSignatureList({
    this.sigs = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sigs,
      ];


HederaSignatureList copyWith(
{List<HederaSignature>? sigs,

}) {
    return HederaSignatureList(
sigs: sigs ?? this.sigs,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sigs': sigs.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaSignatureList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSignatureList(
      sigs: (json.valueEnsureAsList<dynamic>('sigs', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaSignature, Object>(
          value: e,
          parse: (v) => HederaSignature.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaSignatureList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignatureList(
      sigs: decode.getListOfBytes(2).map((b) => HederaSignature.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSignatureList;

}


/// *
///  * A public key and signature pair.&lt;br/&gt;
///  * Only Ed25519 and ECDSA(secp256k1) keys and signatures are currently supported
///  * as cryptographic (non-implied) signatures.
class HederaSignaturePair extends HederaProtoMessage with Equality {
    /// *
  ///      * Prefix bytes of the public key.
  ///      * &lt;p&gt;
  ///      * The client may use any number of bytes from zero to the whole length of
  ///      * the public key for pubKeyPrefix. If zero bytes are used, then it MUST be
  ///      * true that only one cryptographic key is required to sign the associated
  ///      * transaction.&lt;br/&gt;
  ///      * If the `pubKeyPrefix` is 0 bytes and more than a single cryptographic
  ///      * key is required to sign the transaction, the request SHALL resolve to
  ///      * `INVALID_SIGNATURE`.
  ///      * &lt;blockquote&gt;Important Note&lt;blockquote&gt;
  ///      * In the special case that a signature is provided to authorize a
  ///      * precompiled contract, the `pubKeyPrefix` MUST contain the _entire public
  ///      * key_.&lt;br/&gt;
  ///      * That is, if the key is an Ed25519 key, the `pubKeyPrefix` MUST be
  ///      * 32 bytes long and contain the full public key bytes.&lt;br/&gt;
  ///      * If the key is an ECDSA(secp256k1) key, the `pubKeyPrefix` MUST be
  ///      * 33 bytes long and contain the full _compressed_ form of the public key.
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  ///      * &lt;p&gt;
  ///      * &lt;dl&gt;&lt;dt&gt;Purpose&lt;/dt&gt;
  ///      * &lt;dd&gt;The `pubKeyPrefix` exists to save cost. A signed transaction with
  ///      * shorter prefixes will have fewer bytes, and so will have a lower
  ///      * transaction fee.
  ///      * The prefixes, however, MUST be long enough to distinguish between all
  ///      * of the public keys that might be signing the transaction. Therefore,
  ///      * software signing a transaction SHOULD evaluate which keys might possibly
  ///      * be required to sign a transaction, and ensure that the shortest prefix
  ///      * that is sufficient to unambiguously identify the correct key is used.
  ///      * &lt;/dd&gt;&lt;/dl&gt;
  final List<int>? pubKeyPrefix;

    /// *
  ///          * A smart contract virtual signature.
  ///          * &lt;p&gt;
  ///          * This value MUST be length zero, if set.
  final List<int>? contract;

    /// *
  ///          * An Ed25519 signature.
  final List<int>? ed25519;

    /// *
  ///          * This option is not supported.&lt;br/&gt;
  ///          * A RSA-3072 signature.
  final List<int>? rsa3072;

    /// *
  ///          * This option is not supported.&lt;br/&gt;
  ///          * ECDSA p-384 signature.
  final List<int>? ecdsa384;

    /// *
  ///          * An ECDSA(secp256k1) signature.
  final List<int>? ecdsaSecp256k1;

  const HederaSignaturePair({
    this.pubKeyPrefix,
    this.contract,
    this.ed25519,
    this.rsa3072,
    this.ecdsa384,
    this.ecdsaSecp256k1,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.bytes(5, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.bytes(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        pubKeyPrefix,
        contract,
        ed25519,
        rsa3072,
        ecdsa384,
        ecdsaSecp256k1,
      ];


HederaSignaturePair copyWith(
{List<int>? pubKeyPrefix,

List<int>? contract,

List<int>? ed25519,

List<int>? rsa3072,

List<int>? ecdsa384,

List<int>? ecdsaSecp256k1,

}) {
    return HederaSignaturePair(
pubKeyPrefix: pubKeyPrefix ?? this.pubKeyPrefix,
contract: contract ?? this.contract,
ed25519: ed25519 ?? this.ed25519,
rsa3072: rsa3072 ?? this.rsa3072,
ecdsa384: ecdsa384 ?? this.ecdsa384,
ecdsaSecp256k1: ecdsaSecp256k1 ?? this.ecdsaSecp256k1,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'pubKeyPrefix': config.encodeBinary(pubKeyPrefix),
      'contract': config.encodeBinary(contract),
      'ed25519': config.encodeBinary(ed25519),
      'RSA_3072': config.encodeBinary(rsa3072),
      'ECDSA_384': config.encodeBinary(ecdsa384),
      'ECDSA_secp256k1': config.encodeBinary(ecdsaSecp256k1),
    };
  }


  factory HederaSignaturePair.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSignaturePair(
      pubKeyPrefix: config.decodeBinary<List<int>?>(json.valueAs('pubKeyPrefix', normalizeKeyLookup: config.normalizeKeys)),
      contract: config.decodeBinary<List<int>?>(json.valueAs('contract', normalizeKeyLookup: config.normalizeKeys)),
      ed25519: config.decodeBinary<List<int>?>(json.valueAs('ed25519', normalizeKeyLookup: config.normalizeKeys)),
      rsa3072: config.decodeBinary<List<int>?>(json.valueAs('RSA_3072', normalizeKeyLookup: config.normalizeKeys)),
      ecdsa384: config.decodeBinary<List<int>?>(json.valueAs('ECDSA_384', normalizeKeyLookup: config.normalizeKeys)),
      ecdsaSecp256k1: config.decodeBinary<List<int>?>(json.valueAs('ECDSA_secp256k1', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaSignaturePair.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignaturePair(
      pubKeyPrefix: decode.getBytes<List<int>?>(1),
      contract: decode.getBytes<List<int>?>(2),
      ed25519: decode.getBytes<List<int>?>(3),
      rsa3072: decode.getBytes<List<int>?>(4),
      ecdsa384: decode.getBytes<List<int>?>(5),
      ecdsaSecp256k1: decode.getBytes<List<int>?>(6),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSignaturePair;

}


/// *
///  * A set of signatures corresponding to every unique public key that
///  * signed a given transaction.
///  *
///  * If any public key matches more than one prefix in the signature map,
///  * the transaction containing that map SHALL fail immediately with the
///  * response code `KEY_PREFIX_MISMATCH`.
class HederaSignatureMap extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of signature pairs for a specific transaction.&lt;br/&gt;
  ///      * Each signature pair represents a single cryptographic (`primitive`)
  ///      * public key identified by a "prefix" value and the cryptographic
  ///      * signature produced for that key.
  final List<HederaSignaturePair> sigPair;

  const HederaSignatureMap({
    this.sigPair = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sigPair,
      ];


HederaSignatureMap copyWith(
{List<HederaSignaturePair>? sigPair,

}) {
    return HederaSignatureMap(
sigPair: sigPair ?? this.sigPair,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sigPair': sigPair.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaSignatureMap.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSignatureMap(
      sigPair: (json.valueEnsureAsList<dynamic>('sigPair', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaSignaturePair, Object>(
          value: e,
          parse: (v) => HederaSignaturePair.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaSignatureMap.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignatureMap(
      sigPair: decode.getListOfBytes(1).map((b) => HederaSignaturePair.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSignatureMap;

}


/// *
///  * A set of values the nodes use in determining transaction and query fees, and
///  * constants involved in fee calculations.
///  *
///  * Nodes SHALL multiply the amount of "resources" allocated to a transaction or
///  * query by the corresponding price to calculate the appropriate fee. Units are
///  * one-thousandth of a `tinyCent`. The "resource" allocations SHALL be estimated
///  * based on transaction characteristics and current network state, and MAY be
///  * further adjusted based on network load and congestion.
///  *
///  * This SHALL be used, in different contexts, for the cost _factors_ used to
///  * calculate charged amounts, for the resource accumulation, and for actual
///  * amounts to be charged.&lt;br/&gt;
///  * Amounts recorded here MUST be converted to tinybar according to the
///  * current active `ExchangeRate` for the network.
class HederaFeeComponents extends HederaProtoMessage with Equality {
    /// *
  ///      * Base: "minimum total fee".
  ///      * &lt;p&gt;
  ///      * The calculated fee MUST be greater than this value.
  final BigInt? min;

    /// *
  ///      * Base: "maximum total fee".
  ///      * &lt;p&gt;
  ///      * The calculated fee MUST be less than this value.
  final BigInt? max;

    /// *
  ///      * Base: "constant fee".&lt;br/&gt;
  ///      * A baseline constant contribution to total fee.
  final BigInt? constant;

    /// *
  ///      * Bandwidth: "bytes per transaction".&lt;br/&gt;
  ///      * The fee for bandwidth consumed by a transaction, measured in bytes
  final BigInt? bpt;

    /// *
  ///      * Signatures: "validations per transaction".&lt;br/&gt;
  ///      * The fee for signature verifications required by a transaction
  final BigInt? vpt;

    /// *
  ///      * Memory: "RAM byte-hours".&lt;br/&gt;
  ///      * The fee for RAM required to process a transaction,
  ///      * measured in byte-hours
  final BigInt? rbh;

    /// *
  ///      * Disk: "storage byte-hours".&lt;br/&gt;
  ///      * The fee for storage required by a transaction, measured in byte-hours
  final BigInt? sbh;

    /// *
  ///      * Compute: Ethereum term for a derivative EVM compute resource.&lt;br/&gt;
  ///      * The fee of computation for a smart contract transaction. The value of
  ///      * gas is set by a conversion rate, and is regularly updated to reflect
  ///      * reasonable and customary costs.
  final BigInt? gas;

    /// *
  ///      * Ad valorem: "transferred value".&lt;br/&gt;
  ///      * The fee for HBAR transferred by a transaction.
  final BigInt? tv;

    /// *
  ///      * Response memory: "bytes per response".&lt;br/&gt;
  ///      * The fee for data retrieved from memory to deliver a response,
  ///      * measured in bytes
  final BigInt? bpr;

    /// *
  ///      * Response disk: "storage bytes per response".&lt;br/&gt;
  ///      * The fee for data retrieved from disk to deliver a response,
  ///      * measured in bytes
  final BigInt? sbpr;

  const HederaFeeComponents({
    this.min,
    this.max,
    this.constant,
    this.bpt,
    this.vpt,
    this.rbh,
    this.sbh,
    this.gas,
    this.tv,
    this.bpr,
    this.sbpr,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        min,
        max,
        constant,
        bpt,
        vpt,
        rbh,
        sbh,
        gas,
        tv,
        bpr,
        sbpr,
      ];


HederaFeeComponents copyWith(
{BigInt? min,

BigInt? max,

BigInt? constant,

BigInt? bpt,

BigInt? vpt,

BigInt? rbh,

BigInt? sbh,

BigInt? gas,

BigInt? tv,

BigInt? bpr,

BigInt? sbpr,

}) {
    return HederaFeeComponents(
min: min ?? this.min,
max: max ?? this.max,
constant: constant ?? this.constant,
bpt: bpt ?? this.bpt,
vpt: vpt ?? this.vpt,
rbh: rbh ?? this.rbh,
sbh: sbh ?? this.sbh,
gas: gas ?? this.gas,
tv: tv ?? this.tv,
bpr: bpr ?? this.bpr,
sbpr: sbpr ?? this.sbpr,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'min': config.encodeBigint(min),
      'max': config.encodeBigint(max),
      'constant': config.encodeBigint(constant),
      'bpt': config.encodeBigint(bpt),
      'vpt': config.encodeBigint(vpt),
      'rbh': config.encodeBigint(rbh),
      'sbh': config.encodeBigint(sbh),
      'gas': config.encodeBigint(gas),
      'tv': config.encodeBigint(tv),
      'bpr': config.encodeBigint(bpr),
      'sbpr': config.encodeBigint(sbpr),
    };
  }


  factory HederaFeeComponents.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFeeComponents(
      min: json.valueAsBigInt<BigInt?>('min', normalizeKeyLookup: config.normalizeKeys),
      max: json.valueAsBigInt<BigInt?>('max', normalizeKeyLookup: config.normalizeKeys),
      constant: json.valueAsBigInt<BigInt?>('constant', normalizeKeyLookup: config.normalizeKeys),
      bpt: json.valueAsBigInt<BigInt?>('bpt', normalizeKeyLookup: config.normalizeKeys),
      vpt: json.valueAsBigInt<BigInt?>('vpt', normalizeKeyLookup: config.normalizeKeys),
      rbh: json.valueAsBigInt<BigInt?>('rbh', normalizeKeyLookup: config.normalizeKeys),
      sbh: json.valueAsBigInt<BigInt?>('sbh', normalizeKeyLookup: config.normalizeKeys),
      gas: json.valueAsBigInt<BigInt?>('gas', normalizeKeyLookup: config.normalizeKeys),
      tv: json.valueAsBigInt<BigInt?>('tv', normalizeKeyLookup: config.normalizeKeys),
      bpr: json.valueAsBigInt<BigInt?>('bpr', normalizeKeyLookup: config.normalizeKeys),
      sbpr: json.valueAsBigInt<BigInt?>('sbpr', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaFeeComponents.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFeeComponents(
      min: decode.getBigInt<BigInt?>(1),
      max: decode.getBigInt<BigInt?>(2),
      constant: decode.getBigInt<BigInt?>(3),
      bpt: decode.getBigInt<BigInt?>(4),
      vpt: decode.getBigInt<BigInt?>(5),
      rbh: decode.getBigInt<BigInt?>(6),
      sbh: decode.getBigInt<BigInt?>(7),
      gas: decode.getBigInt<BigInt?>(8),
      tv: decode.getBigInt<BigInt?>(9),
      bpr: decode.getBigInt<BigInt?>(10),
      sbpr: decode.getBigInt<BigInt?>(11),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFeeComponents;

}


/// *
///  * The fee schedule for a specific transaction or query based on the fee data.
class HederaTransactionFeeSchedule extends HederaProtoMessage with Equality {
    /// *
  ///      * An enumeration for a particular transaction or query.&lt;br/&gt;
  ///      * The functionality type determines the base cost parameters.
  final HederaHederaFunctionality? hederaFunctionality;

    /// *
  ///      * Use `fees` instead of this field.&lt;br/&gt;
  ///      * Resource price coefficients.
  final HederaFeeData? feeData;

    /// *
  ///      * The resource price coefficients for transaction type and any applicable
  ///      * subtypes.&lt;br/&gt;
  ///      * The multiple entries enable support for subtype price definitions.
  final List<HederaFeeData> fees;

  const HederaTransactionFeeSchedule({
    this.hederaFunctionality,
    this.feeData,
    this.fees = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.message(2, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        hederaFunctionality,
        feeData,
        fees,
      ];


HederaTransactionFeeSchedule copyWith(
{HederaHederaFunctionality? hederaFunctionality,

HederaFeeData? feeData,

List<HederaFeeData>? fees,

}) {
    return HederaTransactionFeeSchedule(
hederaFunctionality: hederaFunctionality ?? this.hederaFunctionality,
feeData: feeData ?? this.feeData,
fees: fees ?? this.fees,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'hederaFunctionality': config.encodeEnum(hederaFunctionality),
      'feeData': config.encodeMessage(feeData),
      'fees': fees.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTransactionFeeSchedule.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransactionFeeSchedule(
      hederaFunctionality: json.valueTo<HederaHederaFunctionality?, Object?>(
        key: 'hederaFunctionality',
        parse: (v) => HederaHederaFunctionality.from(v),
      ),
      feeData: json.valueTo<HederaFeeData?, Object>(
        key: 'feeData',
        parse: (v) => HederaFeeData.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fees: (json.valueEnsureAsList<dynamic>('fees', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaFeeData, Object>(
          value: e,
          parse: (v) => HederaFeeData.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTransactionFeeSchedule.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionFeeSchedule(
      hederaFunctionality: decode.getEnum<HederaHederaFunctionality?>(1, HederaHederaFunctionality.values),
      feeData: decode.messageTo<HederaFeeData?>(2, (b) => HederaFeeData.deserialize(b)),
      fees: decode.getListOfBytes(3).map((b) => HederaFeeData.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTransactionFeeSchedule;

}


/// *
///  * A total fee, in component amounts charged for a transaction.
///  *
///  * Total fees are composed of three sets of components.
///  * - Node data, components that compensate the specific node that submitted
///  *   the transaction.
///  * - Network data, components that compensate the Hedera network for gossiping
///  *   the transaction and determining the consensus timestamp.
///  * - Service data, components that compensate the Hedera network for the ongoing
///  *   maintenance and operation of the network, as well as ongoing development
///  *   of network services.
///  *
///  * Fee components are recorded in thousandths of a tiny cent, and the network
///  * exchange rate converts these to tinybar amounts, which are what the network
///  * charges for transactions and what the network reports in the record stream.
class HederaFeeData extends HederaProtoMessage with Equality {
    /// *
  ///      * Fee components to be paid to the submitting node.
  final HederaFeeComponents? nodedata;

    /// *
  ///      * Fee components to be paid to the network for bringing a
  ///      * transaction to consensus.
  final HederaFeeComponents? networkdata;

    /// *
  ///      * Fee components to be paid to the network for providing the immediate and
  ///      * ongoing services associated with executing the transaction, maintaining
  ///      * the network, and developing the network software.
  final HederaFeeComponents? servicedata;

    /// *
  ///      * A sub-type distinguishing between different types of `FeeData` that may
  ///      * apply to the same base transaction type (associated with
  ///      * an `HederaFunctionality`).
  final HederaSubType? subType;

  const HederaFeeData({
    this.nodedata,
    this.networkdata,
    this.servicedata,
    this.subType,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.enumType(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nodedata,
        networkdata,
        servicedata,
        subType,
      ];


HederaFeeData copyWith(
{HederaFeeComponents? nodedata,

HederaFeeComponents? networkdata,

HederaFeeComponents? servicedata,

HederaSubType? subType,

}) {
    return HederaFeeData(
nodedata: nodedata ?? this.nodedata,
networkdata: networkdata ?? this.networkdata,
servicedata: servicedata ?? this.servicedata,
subType: subType ?? this.subType,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'nodedata': config.encodeMessage(nodedata),
      'networkdata': config.encodeMessage(networkdata),
      'servicedata': config.encodeMessage(servicedata),
      'subType': config.encodeEnum(subType),
    };
  }


  factory HederaFeeData.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFeeData(
      nodedata: json.valueTo<HederaFeeComponents?, Object>(
        key: 'nodedata',
        parse: (v) => HederaFeeComponents.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      networkdata: json.valueTo<HederaFeeComponents?, Object>(
        key: 'networkdata',
        parse: (v) => HederaFeeComponents.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      servicedata: json.valueTo<HederaFeeComponents?, Object>(
        key: 'servicedata',
        parse: (v) => HederaFeeComponents.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      subType: json.valueTo<HederaSubType?, Object?>(
        key: 'subType',
        parse: (v) => HederaSubType.from(v),
      ),
    );
  }

  factory HederaFeeData.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFeeData(
      nodedata: decode.messageTo<HederaFeeComponents?>(1, (b) => HederaFeeComponents.deserialize(b)),
      networkdata: decode.messageTo<HederaFeeComponents?>(2, (b) => HederaFeeComponents.deserialize(b)),
      servicedata: decode.messageTo<HederaFeeComponents?>(3, (b) => HederaFeeComponents.deserialize(b)),
      subType: decode.getEnum<HederaSubType?>(4, HederaSubType.values),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFeeData;

}


/// *
///  * A set of fee schedules covering all transaction types and query types, along
///  * with a specific time at which this fee schedule will expire.
///  *
///  * Nodes SHALL use the most recent unexpired fee schedule to determine the fees
///  * for all transactions based on various resource components imputed to each
///  * transaction.
class HederaFeeSchedule extends HederaProtoMessage with Equality {
    /// *
  ///      * Sets of fee coefficients for various transaction or query types.
  final List<HederaTransactionFeeSchedule> transactionFeeSchedule;

    /// *
  ///      * A time, in seconds since the `epoch`, when this fee schedule
  ///      * will expire.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch
  ///      * with 0 at `1970-01-01T00:00:00.000Z`.
  final proto_timestamp.HederaTimestampSeconds? expiryTime;

  const HederaFeeSchedule({
    this.transactionFeeSchedule = const [],
    this.expiryTime,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transactionFeeSchedule,
        expiryTime,
      ];


HederaFeeSchedule copyWith(
{List<HederaTransactionFeeSchedule>? transactionFeeSchedule,

proto_timestamp.HederaTimestampSeconds? expiryTime,

}) {
    return HederaFeeSchedule(
transactionFeeSchedule: transactionFeeSchedule ?? this.transactionFeeSchedule,
expiryTime: expiryTime ?? this.expiryTime,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transactionFeeSchedule': transactionFeeSchedule.map((e) => config.encodeMessage(e)).toList(),
      'expiryTime': config.encodeMessage(expiryTime),
    };
  }


  factory HederaFeeSchedule.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFeeSchedule(
      transactionFeeSchedule: (json.valueEnsureAsList<dynamic>('transactionFeeSchedule', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaTransactionFeeSchedule, Object>(
          value: e,
          parse: (v) => HederaTransactionFeeSchedule.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      expiryTime: json.valueTo<proto_timestamp.HederaTimestampSeconds?, Object>(
        key: 'expiryTime',
        parse: (v) => proto_timestamp.HederaTimestampSeconds.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaFeeSchedule.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFeeSchedule(
      transactionFeeSchedule: decode.getListOfBytes(1).map((b) => HederaTransactionFeeSchedule.deserialize(b)).toList(),
      expiryTime: decode.messageTo<proto_timestamp.HederaTimestampSeconds?>(2, (b) => proto_timestamp.HederaTimestampSeconds.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFeeSchedule;

}


/// *
///  * The "current" fee schedule and the "next" fee schedule.
///  *
///  * The current fee schedule is the schedule that SHALL apply to the current
///  * transaction.&lt;br/&gt;
///  * The next fee schedule is the schedule that SHALL apply after the current
///  * schedule expires.&lt;br/&gt;
///  * We store both to avoid a condition where transactions are processed very
///  * near the time when a fee schedule expires and it might be indeterminate
///  * which fees to apply. With both current and next fee schedule the network
///  * can deterministically apply the correct fee schedule based on consensus
///  * timestamp for each transaction.
class HederaCurrentAndNextFeeSchedule extends HederaProtoMessage with Equality {
    /// *
  ///      * A current, unexpired, fee schedule.
  final HederaFeeSchedule? currentFeeSchedule;

    /// *
  ///      * A future fee schedule to use when the current schedule expires.
  final HederaFeeSchedule? nextFeeSchedule;

  const HederaCurrentAndNextFeeSchedule({
    this.currentFeeSchedule,
    this.nextFeeSchedule,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        currentFeeSchedule,
        nextFeeSchedule,
      ];


HederaCurrentAndNextFeeSchedule copyWith(
{HederaFeeSchedule? currentFeeSchedule,

HederaFeeSchedule? nextFeeSchedule,

}) {
    return HederaCurrentAndNextFeeSchedule(
currentFeeSchedule: currentFeeSchedule ?? this.currentFeeSchedule,
nextFeeSchedule: nextFeeSchedule ?? this.nextFeeSchedule,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'currentFeeSchedule': config.encodeMessage(currentFeeSchedule),
      'nextFeeSchedule': config.encodeMessage(nextFeeSchedule),
    };
  }


  factory HederaCurrentAndNextFeeSchedule.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCurrentAndNextFeeSchedule(
      currentFeeSchedule: json.valueTo<HederaFeeSchedule?, Object>(
        key: 'currentFeeSchedule',
        parse: (v) => HederaFeeSchedule.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nextFeeSchedule: json.valueTo<HederaFeeSchedule?, Object>(
        key: 'nextFeeSchedule',
        parse: (v) => HederaFeeSchedule.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaCurrentAndNextFeeSchedule.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCurrentAndNextFeeSchedule(
      currentFeeSchedule: decode.messageTo<HederaFeeSchedule?>(1, (b) => HederaFeeSchedule.deserialize(b)),
      nextFeeSchedule: decode.messageTo<HederaFeeSchedule?>(2, (b) => HederaFeeSchedule.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCurrentAndNextFeeSchedule;

}


/// *
///  * A network node endpoint.&lt;br/&gt;
///  * Each network node in the global address book publishes one or more endpoints
///  * which enable the nodes to communicate both with other nodes, for gossip, and
///  * with clients to receive transaction requests.
///  *
///  * This message supports IPv4 with address and TCP port,
///  * and MAY include a FQDN instead of an IP address.&lt;br/&gt;
///  * IPv6 is not currently supported.
///  *
///  * When the `domain_name` field is set, the `ipAddressV4` field
///  * MUST NOT be set.&lt;br/&gt;
///  * When the `ipAddressV4` field is set, the `domain_name` field
///  * MUST NOT be set.
class HederaServiceEndpoint extends HederaProtoMessage with Equality {
    /// *
  ///      * A 32-bit IPv4 address.&lt;br/&gt;
  ///      * This is the address of the endpoint, encoded in pure "big-endian"
  ///      * (i.e. left to right) order (e.g. `127.0.0.1` has hex bytes in the
  ///      * order `7F`, `00`, `00`, `01`).
  final List<int>? ipAddressV4;

    /// *
  ///      * A TCP port to use.
  ///      * &lt;p&gt;
  ///      * This value MUST be between 0 and 65535, inclusive.
  final int? port;

    /// *
  ///      * A node domain name.
  ///      * &lt;p&gt;
  ///      * This MUST be the fully qualified domain name of the node.&lt;br/&gt;
  ///      * This value MUST NOT exceed 253 characters.&lt;br/&gt;
  ///      * When the `domain_name` field is set, the `ipAddressV4`
  ///      * field MUST NOT be set.&lt;br/&gt;
  ///      * When the `ipAddressV4` field is set, the `domain_name`
  ///      * field MUST NOT be set.
  final String? domainName;

  const HederaServiceEndpoint({
    this.ipAddressV4,
    this.port,
    this.domainName,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.string(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        ipAddressV4,
        port,
        domainName,
      ];


HederaServiceEndpoint copyWith(
{List<int>? ipAddressV4,

int? port,

String? domainName,

}) {
    return HederaServiceEndpoint(
ipAddressV4: ipAddressV4 ?? this.ipAddressV4,
port: port ?? this.port,
domainName: domainName ?? this.domainName,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'ipAddressV4': config.encodeBinary(ipAddressV4),
      'port': port,
      'domain_name': domainName,
    };
  }


  factory HederaServiceEndpoint.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServiceEndpoint(
      ipAddressV4: config.decodeBinary<List<int>?>(json.valueAs('ipAddressV4', normalizeKeyLookup: config.normalizeKeys)),
      port: json.valueAsInt<int?>('port', normalizeKeyLookup: config.normalizeKeys),
      domainName: json.valueAsString<String?>('domain_name', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaServiceEndpoint.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaServiceEndpoint(
      ipAddressV4: decode.getBytes<List<int>?>(1),
      port: decode.getInt<int?>(2),
      domainName: decode.getString<String?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoServiceEndpoint;

}


/// *
///  * The data about a node, including its service endpoints and the Hedera account
///  * to be paid for services provided by the node (that is, queries answered and
///  * transactions submitted).
///  *
///  * All active fields are populated in the `0.0.102` address book file.&lt;br/&gt;
///  * Only fields documented with "`0.0.101` field" are populated in the 0.0.101
///  * address book file.
///  *
///  * This message MAY be superseded by messages in state/addressbook/node.proto
///  * and node_get_info.proto.
class HederaNodeAddress extends HederaProtoMessage with Equality {
    /// *
  ///      * ServiceEndpoint is now used to retrieve a node's list of IP
  ///      * addresses and ports.&lt;br/&gt;
  ///      * The IP address of the Node, as a string, encoded in UTF-8.&lt;br/&gt;
  ///      * This value SHALL NOT be populated.
  final List<int>? ipAddress;

    /// *
  ///      * ServiceEndpoint is now used to retrieve a node's list of IP
  ///      * addresses and ports.&lt;br/&gt;
  ///      * The port number of the grpc server for the node.&lt;br/&gt;
  ///      * This value SHALL NOT be populated.
  final int? portno;

    /// *
  ///      * Description provides short text functionality.&lt;br/&gt;
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This field SHALL NOT be populated.
  final List<int>? memo;

    /// *
  ///      * A hexadecimal String encoding of an X509 public key.
  ///      * &lt;p&gt;
  ///      * This X509 RSA _public_ key SHALL be used to verify record stream files
  ///      * (e.g., record stream files).&lt;br/&gt;
  ///      * This field SHALL be a string of hexadecimal characters, encoded UTF-8,
  ///      * which, translated to binary, form the public key DER encoding.
  final String? rsaPubKey;

    /// *
  ///      * A numeric identifier for the node.
  ///      * &lt;p&gt;
  ///      * This value SHALL NOT be sequential.
  ///      * &lt;p&gt;
  ///      * A `0.0.101` field
  final BigInt? nodeId;

    /// *
  ///      * An account to be paid the "node" portion of transaction fees.&lt;br/&gt;
  ///      * The "node" fees are paid to the node that submitted the transaction.
  ///      * &lt;p&gt;
  ///      * A `0.0.101` field
  final HederaAccountID? nodeAccountId;

    /// *
  ///      * A hash of the node's TLS certificate.
  ///      * &lt;p&gt;
  ///      * This field SHALL be a string of hexadecimal characters, encoded UTF-8,
  ///      * which, translated to binary, form a SHA-384 hash of the node's TLS
  ///      * certificate in PEM format.
  ///      * This TLS certificate MUST be encoded UTF-8 and normalized according to
  ///      * the NFKD form prior to computing the hash value.&lt;br/&gt;
  ///      * The value of this field SHALL be used to verify the node TLS
  ///      * certificate when presented during protocol negotiation.
  ///      * &lt;p&gt;
  ///      * A `0.0.101` field
  final List<int>? nodeCertHash;

    /// *
  ///      * A node's service IP addresses and TCP ports.&lt;br/&gt;
  ///      * Nodes require multiple endpoints to ensure that inter-node communication
  ///      * (e.g. gossip) is properly separated from client communication to
  ///      * API endpoints.
  ///      * &lt;p&gt;
  ///      * A `0.0.101` field
  final List<HederaServiceEndpoint> serviceEndpoint;

    /// *
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? description;

    /// *
  ///      * This is replaced by per-account stake tracking and dynamic
  ///      * calculation.&lt;br/&gt;
  ///      * The amount of tinybar staked to the node.&lt;br/&gt;
  ///      * This value SHOULD NOT be populated, and SHALL be ignored.
  final BigInt? stake;

  const HederaNodeAddress({
    this.ipAddress,
    this.portno,
    this.memo,
    this.rsaPubKey,
    this.nodeId,
    this.nodeAccountId,
    this.nodeCertHash,
    this.serviceEndpoint = const [],
    this.description,
    this.stake,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.int32(2, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.bytes(3, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.string(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.string(9),
        ProtoFieldConfig.int64(10, options: [ProtoOptionBool(name: "deprecated", value: true)]),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        ipAddress,
        portno,
        memo,
        rsaPubKey,
        nodeId,
        nodeAccountId,
        nodeCertHash,
        serviceEndpoint,
        description,
        stake,
      ];


HederaNodeAddress copyWith(
{List<int>? ipAddress,

int? portno,

List<int>? memo,

String? rsaPubKey,

BigInt? nodeId,

HederaAccountID? nodeAccountId,

List<int>? nodeCertHash,

List<HederaServiceEndpoint>? serviceEndpoint,

String? description,

BigInt? stake,

}) {
    return HederaNodeAddress(
ipAddress: ipAddress ?? this.ipAddress,
portno: portno ?? this.portno,
memo: memo ?? this.memo,
rsaPubKey: rsaPubKey ?? this.rsaPubKey,
nodeId: nodeId ?? this.nodeId,
nodeAccountId: nodeAccountId ?? this.nodeAccountId,
nodeCertHash: nodeCertHash ?? this.nodeCertHash,
serviceEndpoint: serviceEndpoint ?? this.serviceEndpoint,
description: description ?? this.description,
stake: stake ?? this.stake,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'ipAddress': config.encodeBinary(ipAddress),
      'portno': portno,
      'memo': config.encodeBinary(memo),
      'RSA_PubKey': rsaPubKey,
      'nodeId': config.encodeBigint(nodeId),
      'nodeAccountId': config.encodeMessage(nodeAccountId),
      'nodeCertHash': config.encodeBinary(nodeCertHash),
      'serviceEndpoint': serviceEndpoint.map((e) => config.encodeMessage(e)).toList(),
      'description': description,
      'stake': config.encodeBigint(stake),
    };
  }


  factory HederaNodeAddress.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeAddress(
      ipAddress: config.decodeBinary<List<int>?>(json.valueAs('ipAddress', normalizeKeyLookup: config.normalizeKeys)),
      portno: json.valueAsInt<int?>('portno', normalizeKeyLookup: config.normalizeKeys),
      memo: config.decodeBinary<List<int>?>(json.valueAs('memo', normalizeKeyLookup: config.normalizeKeys)),
      rsaPubKey: json.valueAsString<String?>('RSA_PubKey', normalizeKeyLookup: config.normalizeKeys),
      nodeId: json.valueAsBigInt<BigInt?>('nodeId', normalizeKeyLookup: config.normalizeKeys),
      nodeAccountId: json.valueTo<HederaAccountID?, Object>(
        key: 'nodeAccountId',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nodeCertHash: config.decodeBinary<List<int>?>(json.valueAs('nodeCertHash', normalizeKeyLookup: config.normalizeKeys)),
      serviceEndpoint: (json.valueEnsureAsList<dynamic>('serviceEndpoint', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaServiceEndpoint, Object>(
          value: e,
          parse: (v) => HederaServiceEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      description: json.valueAsString<String?>('description', normalizeKeyLookup: config.normalizeKeys),
      stake: json.valueAsBigInt<BigInt?>('stake', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaNodeAddress.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeAddress(
      ipAddress: decode.getBytes<List<int>?>(1),
      portno: decode.getInt<int?>(2),
      memo: decode.getBytes<List<int>?>(3),
      rsaPubKey: decode.getString<String?>(4),
      nodeId: decode.getBigInt<BigInt?>(5),
      nodeAccountId: decode.messageTo<HederaAccountID?>(6, (b) => HederaAccountID.deserialize(b)),
      nodeCertHash: decode.getBytes<List<int>?>(7),
      serviceEndpoint: decode.getListOfBytes(8).map((b) => HederaServiceEndpoint.deserialize(b)).toList(),
      description: decode.getString<String?>(9),
      stake: decode.getBigInt<BigInt?>(10),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNodeAddress;

}


/// *
///  * A list of nodes and their metadata that contains details of the nodes
///  * running the network.
///  *
///  * Used to parse the contents of system files `0.0.101` and `0.0.102`.
class HederaNodeAddressBook extends HederaProtoMessage with Equality {
    /// *
  ///      * Published data for all nodes in the network
  final List<HederaNodeAddress> nodeAddress;

  const HederaNodeAddressBook({
    this.nodeAddress = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nodeAddress,
      ];


HederaNodeAddressBook copyWith(
{List<HederaNodeAddress>? nodeAddress,

}) {
    return HederaNodeAddressBook(
nodeAddress: nodeAddress ?? this.nodeAddress,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'nodeAddress': nodeAddress.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaNodeAddressBook.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeAddressBook(
      nodeAddress: (json.valueEnsureAsList<dynamic>('nodeAddress', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaNodeAddress, Object>(
          value: e,
          parse: (v) => HederaNodeAddress.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaNodeAddressBook.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeAddressBook(
      nodeAddress: decode.getListOfBytes(1).map((b) => HederaNodeAddress.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNodeAddressBook;

}


/// *
///  * A software version according to "[semantic versioning](https://semver.org/)"
///  * or "date versioning".
///  *
///  * Hedera currently modifies the "typical" semantic versioning somewhat, the
///  * `major` version is always `0`, and each release increments the `minor`
///  * version. The `patch` and `pre` components are used in the typical manner.
///  * The `build` component is not generally used.
class HederaSemanticVersion extends HederaProtoMessage with Equality {
    /// *
  ///      * A major version.&lt;br/&gt;
  ///      * Hedera does not increment this value and retains a `0` value to
  ///      * indicate that API may change for any release.
  ///      * &lt;p&gt;
  ///      * This value SHALL increment for an incompatible API change.&lt;br/&gt;
  final int? major;

    /// *
  ///      * A minor version.&lt;br/&gt;
  ///      * Hedera increments this value with each release.&lt;br/&gt;
  ///      * There may be incompatible API changes in any Hedera Services release.
  ///      * &lt;p&gt;
  ///      * This value SHALL increment for backwards-compatible new
  ///      * functionality.
  final int? minor;

    /// *
  ///      * A patch version.
  ///      * &lt;p&gt;
  ///      * This value SHALL increment for backwards-compatible bug fixes.
  final int? patch;

    /// *
  ///      * A pre-release version.
  ///      * &lt;p&gt;
  ///      * This MAY be denoted by appending a hyphen and a series of dot separated
  ///      * identifiers per [Semver Specification](https://semver.org/#spec-item-9);
  ///      * given a string `0.14.0-alpha.1+21AF26D3`, this field would contain
  ///      * 'alpha.1'
  final String? pre;

    /// *
  ///      * A build version.
  ///      * &lt;p&gt;
  ///      * Build version MAY be denoted by appending a plus sign and a series of
  ///      * dot separated identifiers immediately following the patch or pre-release
  ///      * version per [Semver Specification](https://semver.org/#spec-item-10); so
  ///      * given a string `0.14.0-alpha.1+21AF26D3`, this field
  ///      * would contain '21AF26D3'
  final String? build;

  const HederaSemanticVersion({
    this.major,
    this.minor,
    this.patch,
    this.pre,
    this.build,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.string(4),
        ProtoFieldConfig.string(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        major,
        minor,
        patch,
        pre,
        build,
      ];


HederaSemanticVersion copyWith(
{int? major,

int? minor,

int? patch,

String? pre,

String? build,

}) {
    return HederaSemanticVersion(
major: major ?? this.major,
minor: minor ?? this.minor,
patch: patch ?? this.patch,
pre: pre ?? this.pre,
build: build ?? this.build,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'major': major,
      'minor': minor,
      'patch': patch,
      'pre': pre,
      'build': build,
    };
  }


  factory HederaSemanticVersion.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSemanticVersion(
      major: json.valueAsInt<int?>('major', normalizeKeyLookup: config.normalizeKeys),
      minor: json.valueAsInt<int?>('minor', normalizeKeyLookup: config.normalizeKeys),
      patch: json.valueAsInt<int?>('patch', normalizeKeyLookup: config.normalizeKeys),
      pre: json.valueAsString<String?>('pre', normalizeKeyLookup: config.normalizeKeys),
      build: json.valueAsString<String?>('build', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaSemanticVersion.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSemanticVersion(
      major: decode.getInt<int?>(1),
      minor: decode.getInt<int?>(2),
      patch: decode.getInt<int?>(3),
      pre: decode.getString<String?>(4),
      build: decode.getString<String?>(5),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSemanticVersion;

}


/// *
///  * A single runtime configuration setting.
///  *
///  * Typically a name-value pair, this may also contain a small amount of
///  * associated data.
class HederaSetting extends HederaProtoMessage with Equality {
    /// *
  ///      * A name for this setting property.
  final String? name;

    /// *
  ///      * A value for this setting property.
  final String? value;

    /// *
  ///      * A small quantity of data associated with this setting.
  ///      * &lt;p&gt;
  ///      * This SHOULD be less than 100 bytes.&lt;br/&gt;
  ///      * If the value is a string, it MUST be encoded UTF-8.
  final List<int>? data;

  const HederaSetting({
    this.name,
    this.value,
    this.data,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
        value,
        data,
      ];


HederaSetting copyWith(
{String? name,

String? value,

List<int>? data,

}) {
    return HederaSetting(
name: name ?? this.name,
value: value ?? this.value,
data: data ?? this.data,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': name,
      'value': value,
      'data': config.encodeBinary(data),
    };
  }


  factory HederaSetting.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSetting(
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
      value: json.valueAsString<String?>('value', normalizeKeyLookup: config.normalizeKeys),
      data: config.decodeBinary<List<int>?>(json.valueAs('data', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaSetting.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSetting(
      name: decode.getString<String?>(1),
      value: decode.getString<String?>(2),
      data: decode.getBytes<List<int>?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSetting;

}


/// *
///  * Setting values representing a source of runtime configuration information.
class HederaServicesConfigurationList extends HederaProtoMessage with Equality {
    /// *
  ///      * A List of `Setting` values, typically read from application properties.
  final List<HederaSetting> nameValue;

  const HederaServicesConfigurationList({
    this.nameValue = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nameValue,
      ];


HederaServicesConfigurationList copyWith(
{List<HederaSetting>? nameValue,

}) {
    return HederaServicesConfigurationList(
nameValue: nameValue ?? this.nameValue,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'nameValue': nameValue.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaServicesConfigurationList.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServicesConfigurationList(
      nameValue: (json.valueEnsureAsList<dynamic>('nameValue', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaSetting, Object>(
          value: e,
          parse: (v) => HederaSetting.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaServicesConfigurationList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaServicesConfigurationList(
      nameValue: decode.getListOfBytes(1).map((b) => HederaSetting.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoServicesConfigurationList;

}


/// *
///  * An Hedera Token Service token relationship. A token relationship describes
///  * the connection between an Account and a Token type, including the current
///  * account balance in that token.
///  *
///  * A `TokenRelationship` SHALL contain, for the designated token and enclosing
///  * account, The account's current balance, whether the account has KYC granted,
///  * whether the assets are frozen and whether the association was automatic.&lt;br/&gt;
///  * A `TokenRelationship` MAY also contain the `symbol` and `decimals` values
///  * copied from the token.&lt;br/&gt;
///  * `TokenRelationship` entries SHALL be valid only within the context of a
///  * `GetAccountDetails` query response, or other enclosing message, which
///  * specifies the account side of the relationship.
class HederaTokenRelationship extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This MUST match an existing token that is not deleted.
  final HederaTokenID? tokenId;

    /// *
  ///      * A token symbol.
  ///      * &lt;p&gt;
  ///      * This MUST match an existing token that is not deleted.&lt;br/&gt;
  ///      * This MUST match the value for the token identified in `tokenId`.
  final String? symbol;

    /// *
  ///      * An account balance for this token.
  ///      * &lt;p&gt;
  ///      * For fungible/common tokens this SHALL be the balance that the
  ///      * account holds of that token. The value is provided as an integer amount
  ///      * of the smallest unit of the token (i.e. 10&lt;sup&gt;`-decimals`&lt;/sup&gt; whole
  ///      * tokens).&lt;br/&gt;
  ///      * For non-fungible/unique tokens this SHALL be the whole number of
  ///      * unique tokens held by the account for this token type.
  final BigInt? balance;

    /// *
  ///      * A KYC status for the account with respect to this token.
  ///      * &lt;p&gt;
  ///      * This may be `KycNotApplicable`, `Granted` or `Revoked` and, if KYC is
  ///      * not supported for this token (e.g. the `kyc_key` of the token is not
  ///      * set), this SHALL be `KycNotApplicable`.
  final HederaTokenKycStatus? kycStatus;

    /// *
  ///      * A Freeze status for the account with respect to this token.
  ///      * &lt;p&gt;
  ///      * This value SHALL be one of `FreezeNotApplicable`, `Frozen`
  ///      * or `Unfrozen`.&lt;br/&gt;
  ///      * If the token cannot freeze account assets (e.g. the `freeze_key` of the
  ///      * token is not set), this SHALL be `FreezeNotApplicable`.
  final HederaTokenFreezeStatus? freezeStatus;

    /// *
  ///      * A maximum "precision" for this token.
  ///      * &lt;p&gt;
  ///      * This value MUST match the `decimals` field of the token identified in
  ///      * the `tokenId` field.&lt;br/&gt;
  ///      * A single whole token SHALL be divided into at most
  ///      * 10&lt;sup&gt;`decimals`&lt;/sup&gt; sub-units.
  final int? decimals;

    /// *
  ///      * An automatic association flag.
  ///      * &lt;p&gt;
  ///      * This SHALL be set if the relationship was created implicitly
  ///      * (automatically).&lt;br/&gt;
  ///      * This SHALL be unset if the relationship was created explicitly
  ///      * (manually) via a `TokenAssociate` transaction.
  final bool? automaticAssociation;

  const HederaTokenRelationship({
    this.tokenId,
    this.symbol,
    this.balance,
    this.kycStatus,
    this.freezeStatus,
    this.decimals,
    this.automaticAssociation,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.enumType(4),
        ProtoFieldConfig.enumType(5),
        ProtoFieldConfig.uint32(6),
        ProtoFieldConfig.bool(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        symbol,
        balance,
        kycStatus,
        freezeStatus,
        decimals,
        automaticAssociation,
      ];


HederaTokenRelationship copyWith(
{HederaTokenID? tokenId,

String? symbol,

BigInt? balance,

HederaTokenKycStatus? kycStatus,

HederaTokenFreezeStatus? freezeStatus,

int? decimals,

bool? automaticAssociation,

}) {
    return HederaTokenRelationship(
tokenId: tokenId ?? this.tokenId,
symbol: symbol ?? this.symbol,
balance: balance ?? this.balance,
kycStatus: kycStatus ?? this.kycStatus,
freezeStatus: freezeStatus ?? this.freezeStatus,
decimals: decimals ?? this.decimals,
automaticAssociation: automaticAssociation ?? this.automaticAssociation,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'tokenId': config.encodeMessage(tokenId),
      'symbol': symbol,
      'balance': config.encodeBigint(balance),
      'kycStatus': config.encodeEnum(kycStatus),
      'freezeStatus': config.encodeEnum(freezeStatus),
      'decimals': decimals,
      'automatic_association': automaticAssociation,
    };
  }


  factory HederaTokenRelationship.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenRelationship(
      tokenId: json.valueTo<HederaTokenID?, Object>(
        key: 'tokenId',
        parse: (v) => HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      symbol: json.valueAsString<String?>('symbol', normalizeKeyLookup: config.normalizeKeys),
      balance: json.valueAsBigInt<BigInt?>('balance', normalizeKeyLookup: config.normalizeKeys),
      kycStatus: json.valueTo<HederaTokenKycStatus?, Object?>(
        key: 'kycStatus',
        parse: (v) => HederaTokenKycStatus.from(v),
      ),
      freezeStatus: json.valueTo<HederaTokenFreezeStatus?, Object?>(
        key: 'freezeStatus',
        parse: (v) => HederaTokenFreezeStatus.from(v),
      ),
      decimals: json.valueAsInt<int?>('decimals', normalizeKeyLookup: config.normalizeKeys),
      automaticAssociation: json.valueAsBool<bool?>('automatic_association', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTokenRelationship.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenRelationship(
      tokenId: decode.messageTo<HederaTokenID?>(1, (b) => HederaTokenID.deserialize(b)),
      symbol: decode.getString<String?>(2),
      balance: decode.getBigInt<BigInt?>(3),
      kycStatus: decode.getEnum<HederaTokenKycStatus?>(4, HederaTokenKycStatus.values),
      freezeStatus: decode.getEnum<HederaTokenFreezeStatus?>(5, HederaTokenFreezeStatus.values),
      decimals: decode.getInt<int?>(6),
      automaticAssociation: decode.getBool<bool?>(7),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenRelationship;

}


/// *
///  * A number of _transferable units_ of a specified token.
///  *
///  * The transferable unit of a token is its smallest denomination, as given by
///  * the token's `decimals` property. Each minted token contains
///  * 10&lt;sup&gt;`decimals`&lt;/sup&gt; transferable units. For example, we could think of
///  * the cent as the transferable unit of the US dollar (`decimals=2`); and the
///  * tinybar as the transferable unit of HBAR (`decimals=8`).
///  *
///  * Transferable units are not directly comparable across different tokens.
class HederaTokenBalance extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.
  final HederaTokenID? tokenId;

    /// *
  ///      * A number of transferable units of the identified token.
  ///      * &lt;p&gt;
  ///      * For fungible/common tokens this SHALL be the balance, in units of
  ///      * 10&lt;sup&gt;`-decimals`&lt;/sup&gt; whole tokens.&lt;br/&gt;
  ///      * For non-fungible/unique tokens, this SHALL be the number of
  ///      * individual unique tokens in this balance.
  final BigInt? balance;

    /// *
  ///      * A number of "decimals" precision.
  ///      * &lt;p&gt;
  ///      * This MUST match the `decimals` value for the token identified by the
  ///      * `tokenId` field.
  final int? decimals;

  const HederaTokenBalance({
    this.tokenId,
    this.balance,
    this.decimals,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.uint32(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        balance,
        decimals,
      ];


HederaTokenBalance copyWith(
{HederaTokenID? tokenId,

BigInt? balance,

int? decimals,

}) {
    return HederaTokenBalance(
tokenId: tokenId ?? this.tokenId,
balance: balance ?? this.balance,
decimals: decimals ?? this.decimals,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'tokenId': config.encodeMessage(tokenId),
      'balance': config.encodeBigint(balance),
      'decimals': decimals,
    };
  }


  factory HederaTokenBalance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenBalance(
      tokenId: json.valueTo<HederaTokenID?, Object>(
        key: 'tokenId',
        parse: (v) => HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      balance: json.valueAsBigInt<BigInt?>('balance', normalizeKeyLookup: config.normalizeKeys),
      decimals: json.valueAsInt<int?>('decimals', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTokenBalance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenBalance(
      tokenId: decode.messageTo<HederaTokenID?>(1, (b) => HederaTokenID.deserialize(b)),
      balance: decode.getBigInt<BigInt?>(2),
      decimals: decode.getInt<int?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenBalance;

}


/// *
///  * A set of token balance values.
///  *
///  * Each entry describes the balance the enclosing account holds for a specific
///  * token. The balance is an amount for a fungible/common token or a count for
///  * a non-fungible/unique token.
class HederaTokenBalances extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of token balance values.&lt;br/&gt;
  ///      * Each entry represents a single account balance for a single token.
  final List<HederaTokenBalance> tokenBalances;

  const HederaTokenBalances({
    this.tokenBalances = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenBalances,
      ];


HederaTokenBalances copyWith(
{List<HederaTokenBalance>? tokenBalances,

}) {
    return HederaTokenBalances(
tokenBalances: tokenBalances ?? this.tokenBalances,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'tokenBalances': tokenBalances.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTokenBalances.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenBalances(
      tokenBalances: (json.valueEnsureAsList<dynamic>('tokenBalances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaTokenBalance, Object>(
          value: e,
          parse: (v) => HederaTokenBalance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTokenBalances.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenBalances(
      tokenBalances: decode.getListOfBytes(1).map((b) => HederaTokenBalance.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenBalances;

}


/// *
///  * An association between a token and an account.
///  *
///  * An account must be associated with a token before that account can transact
///  * in (send or receive) that token.
class HederaTokenAssociation extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier for the associated token.
  final HederaTokenID? tokenId;

    /// *
  ///      * An account identifier for the associated account.
  final HederaAccountID? accountId;

  const HederaTokenAssociation({
    this.tokenId,
    this.accountId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        accountId,
      ];


HederaTokenAssociation copyWith(
{HederaTokenID? tokenId,

HederaAccountID? accountId,

}) {
    return HederaTokenAssociation(
tokenId: tokenId ?? this.tokenId,
accountId: accountId ?? this.accountId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token_id': config.encodeMessage(tokenId),
      'account_id': config.encodeMessage(accountId),
    };
  }


  factory HederaTokenAssociation.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenAssociation(
      tokenId: json.valueTo<HederaTokenID?, Object>(
        key: 'token_id',
        parse: (v) => HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      accountId: json.valueTo<HederaAccountID?, Object>(
        key: 'account_id',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaTokenAssociation.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenAssociation(
      tokenId: decode.messageTo<HederaTokenID?>(1, (b) => HederaTokenID.deserialize(b)),
      accountId: decode.messageTo<HederaAccountID?>(2, (b) => HederaAccountID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenAssociation;

}


/// *
///  * An association between an account and a token; this message exists in addition
///  * to TokenAssociation because we wanted a more readable name for EntityIDPair;
///  * but for the block stream state changes, we *also* needed to preserve the relative
///  * order of the account id and token id. (TokenAssociation accidentally reversed the
///  * order of those fields, changing the serialized bytes and breaking binary-only
///  * replay of state changes.)
class HederaAccountTokenAssociation extends HederaProtoMessage with Equality {
    /// *
  ///      * An account identifier for the associated account.
  final HederaAccountID? accountId;

    /// *
  ///      * A token identifier for the associated token.
  final HederaTokenID? tokenId;

  const HederaAccountTokenAssociation({
    this.accountId,
    this.tokenId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountId,
        tokenId,
      ];


HederaAccountTokenAssociation copyWith(
{HederaAccountID? accountId,

HederaTokenID? tokenId,

}) {
    return HederaAccountTokenAssociation(
accountId: accountId ?? this.accountId,
tokenId: tokenId ?? this.tokenId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'account_id': config.encodeMessage(accountId),
      'token_id': config.encodeMessage(tokenId),
    };
  }


  factory HederaAccountTokenAssociation.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAccountTokenAssociation(
      accountId: json.valueTo<HederaAccountID?, Object>(
        key: 'account_id',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenId: json.valueTo<HederaTokenID?, Object>(
        key: 'token_id',
        parse: (v) => HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaAccountTokenAssociation.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccountTokenAssociation(
      accountId: decode.messageTo<HederaAccountID?>(1, (b) => HederaAccountID.deserialize(b)),
      tokenId: decode.messageTo<HederaTokenID?>(2, (b) => HederaTokenID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAccountTokenAssociation;

}


/// *
///  * Staking information for an account or a contract.
///  *
///  * This is used for responses returned from `CryptoGetInfo` or
///  * `ContractGetInfo` queries.
class HederaStakingInfo extends HederaProtoMessage with Equality {
    /// *
  ///      * A flag indicating that the holder of this account has chosen to decline
  ///      * staking rewards.
  final bool? declineReward;

    /// *
  ///      * A `Timestamp` of the start time for the latest active staking period.
  ///      * &lt;p&gt;
  ///      * This MUST be a period during which either the staking settings for this
  ///      * account or contract changed or the account or contract received staking
  ///      * rewards, whichever is later. Examples of a change in staking settings
  ///      * include starting staking or changing the staked_node_id.&lt;br/&gt;
  ///      * If this account or contract is not currently staked to a node, then this
  ///      * field SHALL NOT be set.
  final proto_timestamp.HederaTimestamp? stakePeriodStart;

    /// *
  ///      * An amount, in tinybar, to be received in the next reward payout.&lt;br/&gt;
  ///      * Rewards are not paid out immediately; for efficiency reasons rewards are
  ///      * only paid out as part of another transaction involving that account.
  final BigInt? pendingReward;

    /// *
  ///      * A proxy-staked balance.&lt;br/&gt;
  ///      * The total HBAR balance of all accounts that delegate staking to this
  ///      * account or contract.
  final BigInt? stakedToMe;

    /// *
  ///          * A delegated stake.
  ///          * &lt;p&gt;
  ///          * This account delegates to the indicated account for staking purposes.
  final HederaAccountID? stakedAccountId;

    /// *
  ///          * A direct stake.
  ///          * &lt;p&gt;
  ///          * This accounts stakes its balance to the designated node.
  final BigInt? stakedNodeId;

  const HederaStakingInfo({
    this.declineReward,
    this.stakePeriodStart,
    this.pendingReward,
    this.stakedToMe,
    this.stakedAccountId,
    this.stakedNodeId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.int64(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        declineReward,
        stakePeriodStart,
        pendingReward,
        stakedToMe,
        stakedAccountId,
        stakedNodeId,
      ];


HederaStakingInfo copyWith(
{bool? declineReward,

proto_timestamp.HederaTimestamp? stakePeriodStart,

BigInt? pendingReward,

BigInt? stakedToMe,

HederaAccountID? stakedAccountId,

BigInt? stakedNodeId,

}) {
    return HederaStakingInfo(
declineReward: declineReward ?? this.declineReward,
stakePeriodStart: stakePeriodStart ?? this.stakePeriodStart,
pendingReward: pendingReward ?? this.pendingReward,
stakedToMe: stakedToMe ?? this.stakedToMe,
stakedAccountId: stakedAccountId ?? this.stakedAccountId,
stakedNodeId: stakedNodeId ?? this.stakedNodeId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'decline_reward': declineReward,
      'stake_period_start': config.encodeMessage(stakePeriodStart),
      'pending_reward': config.encodeBigint(pendingReward),
      'staked_to_me': config.encodeBigint(stakedToMe),
      'staked_account_id': config.encodeMessage(stakedAccountId),
      'staked_node_id': config.encodeBigint(stakedNodeId),
    };
  }


  factory HederaStakingInfo.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaStakingInfo(
      declineReward: json.valueAsBool<bool?>('decline_reward', normalizeKeyLookup: config.normalizeKeys),
      stakePeriodStart: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'stake_period_start',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      pendingReward: json.valueAsBigInt<BigInt?>('pending_reward', normalizeKeyLookup: config.normalizeKeys),
      stakedToMe: json.valueAsBigInt<BigInt?>('staked_to_me', normalizeKeyLookup: config.normalizeKeys),
      stakedAccountId: json.valueTo<HederaAccountID?, Object>(
        key: 'staked_account_id',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      stakedNodeId: json.valueAsBigInt<BigInt?>('staked_node_id', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaStakingInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStakingInfo(
      declineReward: decode.getBool<bool?>(1),
      stakePeriodStart: decode.messageTo<proto_timestamp.HederaTimestamp?>(2, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      pendingReward: decode.getBigInt<BigInt?>(3),
      stakedToMe: decode.getBigInt<BigInt?>(4),
      stakedAccountId: decode.messageTo<HederaAccountID?>(5, (b) => HederaAccountID.deserialize(b)),
      stakedNodeId: decode.getBigInt<BigInt?>(6),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoStakingInfo;

}


/// *
///  * A unique, composite, identifier for a pending airdrop.
///  *
///  * Each pending airdrop SHALL be uniquely identified by
///  * a `PendingAirdropId`.&lt;br/&gt;
///  * A `PendingAirdropId` SHALL be recorded when created and MUST be provided in
///  * any transaction that would modify that pending airdrop
///  * (such as a `claimAirdrop` or `cancelAirdrop`).
class HederaPendingAirdropId extends HederaProtoMessage with Equality {
    /// *
  ///      * A sending account.
  ///      * &lt;p&gt;
  ///      * This is the account that initiated, and SHALL fund,
  ///      * this pending airdrop.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final HederaAccountID? senderId;

    /// *
  ///      * A receiving account.
  ///      * &lt;p&gt;
  ///      * This is the ID of the account that SHALL receive the airdrop.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final HederaAccountID? receiverId;

    /// *
  ///          * A token identifier.&lt;br/&gt;
  ///          * This is the type of token for a fungible/common token airdrop.
  ///          * &lt;p&gt;
  ///          * This field is REQUIRED for a fungible/common token and MUST NOT
  ///          * be used for a non-fungible/unique token.
  final HederaTokenID? fungibleTokenType;

    /// *
  ///          * The id of a single NFT&lt;br/&gt;
  ///          * This is the type of token for a non-fungible/unique token airdrop
  ///          * and consists of a Token ID and serial number.
  ///          * &lt;p&gt;
  ///          * This field is REQUIRED for a non-fungible/unique token and
  ///          * MUST NOT be used for a fungible/common token.
  final HederaNftID? nonFungibleToken;

  const HederaPendingAirdropId({
    this.senderId,
    this.receiverId,
    this.fungibleTokenType,
    this.nonFungibleToken,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        senderId,
        receiverId,
        fungibleTokenType,
        nonFungibleToken,
      ];


HederaPendingAirdropId copyWith(
{HederaAccountID? senderId,

HederaAccountID? receiverId,

HederaTokenID? fungibleTokenType,

HederaNftID? nonFungibleToken,

}) {
    return HederaPendingAirdropId(
senderId: senderId ?? this.senderId,
receiverId: receiverId ?? this.receiverId,
fungibleTokenType: fungibleTokenType ?? this.fungibleTokenType,
nonFungibleToken: nonFungibleToken ?? this.nonFungibleToken,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sender_id': config.encodeMessage(senderId),
      'receiver_id': config.encodeMessage(receiverId),
      'fungible_token_type': config.encodeMessage(fungibleTokenType),
      'non_fungible_token': config.encodeMessage(nonFungibleToken),
    };
  }


  factory HederaPendingAirdropId.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPendingAirdropId(
      senderId: json.valueTo<HederaAccountID?, Object>(
        key: 'sender_id',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      receiverId: json.valueTo<HederaAccountID?, Object>(
        key: 'receiver_id',
        parse: (v) => HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fungibleTokenType: json.valueTo<HederaTokenID?, Object>(
        key: 'fungible_token_type',
        parse: (v) => HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nonFungibleToken: json.valueTo<HederaNftID?, Object>(
        key: 'non_fungible_token',
        parse: (v) => HederaNftID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaPendingAirdropId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPendingAirdropId(
      senderId: decode.messageTo<HederaAccountID?>(1, (b) => HederaAccountID.deserialize(b)),
      receiverId: decode.messageTo<HederaAccountID?>(2, (b) => HederaAccountID.deserialize(b)),
      fungibleTokenType: decode.messageTo<HederaTokenID?>(3, (b) => HederaTokenID.deserialize(b)),
      nonFungibleToken: decode.messageTo<HederaNftID?>(4, (b) => HederaNftID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoPendingAirdropId;

}


/// *
///  * A single pending airdrop value.
///  *
///  * This message SHALL record the airdrop amount for a
///  * fungible/common token.&lt;br/&gt;
///  * This message SHOULD be null for a non-fungible/unique token.&lt;br/&gt;
///  * If a non-null `PendingAirdropValue` is set for a non-fungible/unique
///  * token, the amount field MUST be `0`.
///  *
///  * It is RECOMMENDED that implementations store pending airdrop information
///  * as a key-value map from `PendingAirdropId` to `PendingAirdropValue`, with
///  * a `null` value used for non-fungible pending airdrops.
class HederaPendingAirdropValue extends HederaProtoMessage with Equality {
    /// *
  ///      * An amount to transfer for fungible/common tokens.&lt;br/&gt;
  ///      * This is expressed in the smallest available units for that token
  ///      * (i.e. 10&lt;sup&gt;-`decimals`&lt;/sup&gt; whole tokens).
  ///      * &lt;p&gt;
  ///      * This amount SHALL be transferred from the sender to the receiver,
  ///      * if claimed.&lt;br/&gt;
  ///      * If the token is a fungible/common token, this value MUST be strictly
  ///      * greater than `0`.&lt;br/&gt;
  ///      * If the token is a non-fungible/unique token, this message SHOULD NOT
  ///      * be set, and if set, this field MUST be `0`.
  final BigInt? amount;

  const HederaPendingAirdropValue({
    this.amount,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        amount,
      ];


HederaPendingAirdropValue copyWith(
{BigInt? amount,

}) {
    return HederaPendingAirdropValue(
amount: amount ?? this.amount,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'amount': config.encodeBigint(amount),
    };
  }


  factory HederaPendingAirdropValue.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPendingAirdropValue(
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaPendingAirdropValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPendingAirdropValue(
      amount: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoPendingAirdropValue;

}



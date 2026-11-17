import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Account.
///  * This is a single account within the Hedera network. An Account is the
///  * primary entity representing ownership of assets tracked on the ledger.
///  * Account Allowances are also described here, and these represent permission
///  * granted to an account to transfer assets owned by a different account which
///  * granted the "allowance". Allowances specify the assets and amounts which may
///  * be transferred.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single Account in the Hedera distributed ledger.
///  *
///  * Each Account SHALL have a unique three-part identifier, a Key, and one
///  * or more token balances.&lt;br/&gt;
///  * Each Account SHALL have an alias, which has multiple forms, and MAY be set automatically.&lt;br/&gt;
///  * Several additional items SHALL be associated with the Account to enable
///  * full functionality.&lt;br/&gt;
///  * Assets SHALL be represented as linked-lists with only the "head" item
///  * referenced directly in the Account, and the remaining items SHALL be
///  * accessible via the token relation or unique tokens maps.&lt;br/&gt;
///  * Accounts, as most items in the network, SHALL have an expiration time,
///  * recorded as seconds since the epoch, and MUST be "renewed" for a small fee
///  * at expiration. This helps to reduce the amount of inactive accounts retained
///  * in state.&lt;br/&gt;
///  * Another account MAY be designated to pay any renewal fees and automatically
///  * renew an account for (by default) 30-90 days at a time as a means to
///  * optionally ensure important accounts remain active.&lt;br/&gt;
///  * Accounts MAY participate in securing the network by "staking" the account
///  * balances to a particular network node, and receive a portion of network
///  * fees as a reward. An account MAY optionally decline these rewards but still
///  * stake its balances.&lt;br/&gt;
///  * An account MAY optionally require that inbound transfer transactions be
///  * signed by that account as receiver
///  * (in addition to the sender's signature).&lt;br/&gt;
///  * As with all network entities, Account ID SHALL be represented as
///  * shard.realm.X.&lt;br/&gt;
///  * Alias and contractId SHALL be additional identifiers used to connect accounts
///  * to transactions before the account is fully enabled,
///  * or in EVM contracts.&lt;br/&gt;
///  *
///  * ---
///  *
///  * #### Alias
///  * There is considerable complexity with `alias` (aka `evm_address`) for
///  * Accounts. Much of this comes from the existence of a "hidden" alias for
///  * almost all accounts, and the reuse of the alias field for both EVM reference
///  * and "automatic" account creation.
///  *
///  * For the purposes of this specification, we will use the following terms for
///  * clarity.
///  *   - `key_alias` is the account public key as a protobuf serialized message
///  *     and used for auto-creation and subsequent lookup. This is only valid if
///  *     the account key is a
///  *     single `primitive` key, either ED25519 or ECDSA_SECP256K1.
///  *   - `evm_address` exists for every account and is one of
///  *      - `contract_address`, which is the 20 byte EVM contract address per
///  *        EIP-1014
///  *      - `evm_key_address`, which is the keccak-256 hash of a ECDSA_SECP256K1
///  *        `primitive` key.
///  *         - This is for accounts lazy-created from EVM public keys, when the
///  *           corresponding ECDSA_SECP256K1 public key is presented in a
///  *           transaction signed by the private key for that public key, the
///  *           account is created that key assigned, and the protobuf-serialized
///  *           form is set as the account alias.
///  *      - `long_zero`, is a synthetic 20 byte address inferred for "normally"
///  *        created accounts. It is constructed from the "standard" AccountID as
///  *        follows.
///  *         - 4 byte big-endian shard number
///  *         - 8 byte big-endian realm number
///  *         - 8 byte big-endian entity number
///  *
///  * The `alias` field in the `Account` message SHALL contain one of four values
///  * for any given account.
///  *   - The `key_alias`, if the account was created by transferring HBAR to the
///  *     account referenced by `key_alias`.
///  *   - The `evm_key_address` if the account was created from an EVM public key
///  *   - The `contract_address` if the account belongs to an EVM contract
///  *   - Not-Set/null/Bytes.EMPTY (collectively `null`) if the account was
///  *     created normally
///  *
///  * If the `alias` field of an `Account` is any form of `null`, then the account
///  * MAY be referenced by `alias` in an `AccountID` by using the `long_zero`
///  * address for the account. This "hidden default" alias SHALL NOT be stored,
///  * but is synthesized by the node software as needed, and may be synthesized by
///  * an EVM contract or client software as well.
///  *
///  * An AccountID in a transaction MAY reference an `Account` with
///  * `shard`.`realm`.`alias`.&lt;br/&gt;
///  * If the account `alias` field is set for an Account, that value SHALL be the
///  * account alias.&lt;br/&gt;
///  * If the account `alias` field is not set for an Account, the `long_zero`
///  * alias SHALL be the account alias.
class HederaAccount extends HederaProtoMessage with Equality {
    /// *
  ///      * The unique ID of this account.
  ///      * &lt;p&gt;
  ///      * An account ID, when assigned to this field, SHALL be of
  ///      * the form `shard.realm.number`.&lt;br/&gt;
  ///      * Transactions MAY reference the account by alias, but the account itself
  ///      * MUST always have a purely numeric identifier. This numeric ID is the
  ///      * value used to reference the account in query responses, transaction
  ///      * receipts, transaction records, and the block stream.
  final proto_basic_types.HederaAccountID? accountId;

    /// *
  ///      * An account EVM alias.
  ///      * &lt;p&gt;
  ///      * This is a value used in some contexts to reference an account when the
  ///      * numeric account identifier is not available.&lt;br/&gt;
  ///      * This field, when set to a non-default value, is immutable and
  ///      * SHALL NOT be changed.
  final List<int>? alias;

    /// *
  ///      * The key to be used to sign transactions from this account, if any.
  ///      * &lt;p&gt;
  ///      * This key SHALL NOT be set for hollow accounts until the account
  ///      * is finalized.&lt;br/&gt;
  ///      * This key SHALL be set on all other accounts, except for certain
  ///      * immutable accounts (0.0.800 and 0.0.801) necessary for network function
  ///      * and otherwise secured by the governing council.
  final proto_basic_types.HederaKey? key;

    /// *
  ///      * The current expiration time of this account, in seconds since the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch
  ///      * with 0 at `1970-01-01T00:00:00.000Z`.&lt;br/&gt;
  ///      * This account SHALL be due standard renewal fees when the network
  ///      * consensus time exceeds this time.&lt;br/&gt;
  ///      * If rent and expiration are enabled for the network, and automatic
  ///      * renewal is enabled for this account, renewal fees SHALL be charged
  ///      * after this time, and, if charged, the expiration time SHALL be
  ///      * extended for another renewal period.&lt;br/&gt;
  ///      * This account MAY be expired and removed from state at any point
  ///      * after this time if not renewed.&lt;br/&gt;
  ///      * An account holder MAY extend this time by submitting an account
  ///      * update transaction to modify expiration time, subject to the current
  ///      * maximum expiration time for the network.
  final BigInt? expirationSecond;

    /// *
  ///      * The HBAR balance of this account, in tinybar (10&lt;sup&gt;-8&lt;/sup&gt; HBAR).
  ///      * &lt;p&gt;
  ///      * This value is a signed integer for efficiency, but MUST always
  ///      * be a whole number.
  final BigInt? tinybarBalance;

    /// *
  ///      * A short description of this account.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

    /// *
  ///      * A boolean indicating that this account is deleted.
  final bool? deleted;

    /// *
  ///      * The amount of HBAR staked to this account by others.
  final BigInt? stakedToMe;

    /// *
  ///      * If this account stakes to another account, this value SHALL be set to
  ///      * the time when the current period for staking and reward
  ///      * calculations began.
  final BigInt? stakePeriodStart;

    /// Below comment is NOT included in generated documentation
  /// *
  ///      * ID of the account or node to which this account is staking, if any.
  ///      * &lt;p&gt;
  ///      * if not set this field MAY be interpreted as staked_account_id
  ///      * with value `0.0.0`.
  /// *
  ///          * An identifier for the account to which this account is
  ///          * staking its balances as a proxy.
  ///          * &lt;p&gt;
  ///          * If this account is not currently staking its balances, then this
  ///          * field, if set, SHALL be the sentinel value of `0.0.0`.
  final proto_basic_types.HederaAccountID? stakedAccountId;

    /// *
  ///          * An identifier for the node this account is staked to.
  ///          * &lt;p&gt;
  ///          * If this account is not currently staking its balances, then this
  ///          * field, if set, SHALL be the sentinel value of `-1`.
  ///          * Wallet software SHOULD surface staking issues to users and provide a
  ///          * simple mechanism to update staking to a new node ID in the event the
  ///          * prior staked node ID ceases to be valid.
  ///          * &lt;p&gt;
  ///          * &lt;blockquote&gt;Note: node IDs do fluctuate as node operators change.
  ///          * The Account owner MUST submit a new transaction to change this value
  ///          * if the current node ID changes or ceases to operate as a node. An
  ///          * account with an invalid `staked_node_id` SHALL NOT participate in
  ///          * staking until the `staked_node_id` is updated to a valid node ID.
  ///          * &lt;/blockquote&gt;
  final BigInt? stakedNodeId;

    /// *
  ///      * A boolean indicating that this account has chosen to decline rewards for
  ///      * staking its balances.
  ///      * &lt;p&gt;
  ///      * This account MAY still stake its balances, but SHALL NOT receive reward
  ///      * payments for doing so.
  final bool? declineReward;

    /// *
  ///      * A boolean indicating that the account requires a receiver signature for
  ///      * inbound token transfer transactions.
  ///      * &lt;p&gt;
  ///      * If this value is `true` then a transaction to transfer tokens to this
  ///      * account SHALL NOT succeed unless this account has signed the transfer
  ///      * transaction.
  final bool? receiverSigRequired;

    /// *
  ///      * A token ID at the head of the linked list for this account from the
  ///      * token relations map.&lt;br/&gt;
  ///      * The token relations are connected by including the "next" and "previous"
  ///      * TokenID in each TokenRelation message. The "head" item in that list is
  ///      * found by looking up the TokenRelation with this Account's account_id and
  ///      * this head_token_id. Each subsequent item in the list is found via
  ///      * similar lookup with both an AccountID and a TokenID.
  final proto_basic_types.HederaTokenID? headTokenId;

    /// *
  ///      * A NftID at the head of the linked list for this account from
  ///      * the unique tokens map.&lt;br/&gt;
  ///      * The unique token relations are connected by including the "next" and
  ///      * "previous" NftID in each Nft message. The "head" item in that list is
  ///      * found by looking up the Nft with ID matching this head_nft_id. Each
  ///      * subsequent item in the list is found via similar lookup with the next
  ///      * or previous NftID.
  final proto_basic_types.HederaNftID? headNftId;

    /// *
  ///      * A serial number in the NftID at the head of the linked list for this
  ///      * account from unique tokens map.
  ///      * &lt;p&gt;
  ///      * This MUST match the `serial_number` field of `head_nft_id`.
  final BigInt? headNftSerialNumber;

    /// *
  ///      * A number of non-fungible tokens (NTFs) owned by the account.
  final BigInt? numberOwnedNfts;

    /// *
  ///      * A maximum for the number of tokens that can be automatically
  ///      * associated with this account.
  ///      * &lt;p&gt;
  ///      * If this is less than or equal to `used_auto_associations` (or 0), then
  ///      * this account MUST manually associate with a token before transacting in
  ///      * that token.&lt;br/&gt;
  ///      * This value may also be `-1` to indicate no limit.&lt;br/&gt;
  ///      * This value MUST NOT be less than `-1`.
  final int? maxAutoAssociations;

    /// *
  ///      * A count of used auto-association slots.
  ///      * &lt;p&gt;
  ///      * If this is greater than, or equal to, the current value of
  ///      * `max_auto_associations`, then this account MUST manually associate with
  ///      * a new token before transacting in that token.
  final int? usedAutoAssociations;

    /// *
  ///      * A count of tokens associated with this account.
  ///      * &lt;p&gt;
  ///      * This value determines a portion of the renewal fee for this account.
  final int? numberAssociations;

    /// *
  ///      * A boolean indicating that this account is owned by a smart contract.
  final bool? smartContract;

    /// *
  ///      * A count of tokens with a positive balance associated with this account.
  ///      * &lt;p&gt;
  ///      * If the account has a positive balance in any token,
  ///      * it SHALL NOT be deleted.
  final int? numberPositiveBalances;

    /// *
  ///      * A nonce of this account for Ethereum interoperability.
  final BigInt? ethereumNonce;

    /// *
  ///      * An amount of HBAR staked by this account at the start of
  ///      * the last reward period.
  final BigInt? stakeAtStartOfLastRewardedPeriod;

    /// *
  ///      * An account identifier for automatic renewal.&lt;br/&gt;
  ///      * This is the identifier of another account, in the same shard and
  ///      * realm as this account, that has signed a transaction allowing the
  ///      * network to use its balance, if needed, to automatically extend this
  ///      * account's expiration time during automatic renewal processing.
  ///      * &lt;p&gt;
  ///      * If this is set, and this account lack sufficient HBAR balance to pay
  ///      * renewal fees when due, then the network SHALL deduct the necessary fees
  ///      * from the designated auto renew account, if that account has sufficient
  ///      * balance.
  final proto_basic_types.HederaAccountID? autoRenewAccountId;

    /// *
  ///      * A count of the number of seconds to extend this account's expiration.
  ///      * &lt;p&gt;
  ///      * The network SHALL extend the account's expiration by this number of
  ///      * seconds, if funds are available, upon automatic renewal.&lt;br/&gt;
  ///      * This SHALL NOT apply if the account is already deleted
  ///      * upon expiration.&lt;br/&gt;
  ///      * If this is not provided in an allowed range on account creation, the
  ///      * transaction SHALL fail with INVALID_AUTO_RENEWAL_PERIOD. The default
  ///      * values for the minimum period and maximum period are currently 30 days
  ///      * and 90 days, respectively.
  final BigInt? autoRenewSeconds;

    /// *
  ///      * A count of smart contract key-value pairs.&lt;br/&gt;
  ///      * If this account is a smart-contract, this is the number of key-value
  ///      * pairs stored on the contract.
  ///      * &lt;p&gt;
  ///      * If this account is not a smart contract, this field
  ///      * SHALL NOT be used.&lt;br/&gt;
  ///      * This value SHALL determine a portion of the storage rental
  ///      *fees for the contract.
  final int? contractKvPairsNumber;

    /// *
  ///      * A list of crypto (HBAR) allowances approved by this account.
  ///      * &lt;p&gt;
  ///      * If this is not empty, each allowance SHALL permit a specified "spender"
  ///      * account to spend this account's HBAR balance, up to a designated
  ///      * limit.&lt;br/&gt;
  ///      * This field SHALL permit spending only HBAR balance, not other tokens the
  ///      * account may hold. Allowances for other tokens SHALL be listed in the
  ///      * `token_allowances` field or the `approve_for_all_nft_allowances` field.
  final List<HederaAccountCryptoAllowance> cryptoAllowances;

    /// *
  ///      * A list of non-fungible token (NFT) allowances approved by this account.
  ///      * &lt;p&gt;
  ///      * If this is not empty, each allowance permits a specified "spender"
  ///      * account to transfer _all_ of this account's non-fungible tokens from a
  ///      * particular collection.&lt;br/&gt;
  ///      * Allowances for a specific serial number MUST be directly associated with
  ///      * that specific non-fungible token, rather than the holding account.
  final List<HederaAccountApprovalForAllAllowance> approveForAllNftAllowances;

    /// *
  ///      * A list of fungible token allowances approved by this account.
  ///      * &lt;p&gt;
  ///      * If this is not empty, each allowance permits a specified "spender" to
  ///      * spend this account's fungible tokens, of the designated type, up to a
  ///      * designated limit.
  final List<HederaAccountFungibleTokenAllowance> tokenAllowances;

    /// *
  ///      * A count of tokens for which this account is the treasury account.
  ///      * &lt;p&gt;
  ///      * Each native token is initially created with all tokens held by its
  ///      * treasury, and the owner of that account (which may be a smart contract)
  ///      * determines how those tokens are distributed.
  final int? numberTreasuryTitles;

    /// *
  ///      * A flag indicating that the account is expired and pending removal.
  ///      * &lt;p&gt;
  ///      * When the network checks for entity expiration, it SHALL set this flag if
  ///      * the account expiration time has past and the account has no HBAR
  ///      * sufficient to pay current renewal fees.&lt;br/&gt;
  ///      * If the account has an auto-renew account set with an HBAR balance that
  ///      * could pay for an auto-renewal, then this flag SHALL NOT be set. This
  ///      * ensures the account is not encumbered during the time between expiration
  ///      * and when the auto-renewal processing renews the account.
  final bool? expiredAndPendingRemoval;

    /// *
  ///      * A contract storage key.&lt;br/&gt;
  ///      * This is the first key in the doubly-linked list of this
  ///      * contract's storage mappings.
  ///      * &lt;p&gt;
  ///      * This value SHALL be empty if the account is not a contract or the
  ///      * contract has no storage mappings.
  final List<int>? firstContractStorageKey;

    /// *
  ///      * A pending airdrop ID.&lt;br/&gt;
  ///      * This is the head of the linked list for this account from the
  ///      * account airdrops map.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * The account airdrops SHALL be connected by including the "next" and
  ///      * "previous" `PendingAirdropID` in each `AccountAirdrop` message.&lt;br/&gt;
  ///      * This value SHALL NOT be empty if this account is "sender" for any
  ///      * pending airdrop, and SHALL be empty otherwise.
  final proto_basic_types.HederaPendingAirdropId? headPendingAirdropId;

    /// *
  ///      * A number of pending airdrops.
  ///      * &lt;p&gt;
  ///      * This count SHALL be used to calculate rent _without_ walking the linked
  ///      * list of pending airdrops associated to this account via the
  ///      * `head_pending_airdrop_id` field.&lt;br/&gt;
  ///      * This value MUST be updated for every airdrop, clam, or cancel transaction
  ///      * that designates this account as a receiver.&lt;br/&gt;
  ///      * This number MUST always match the count of entries in the "list"
  ///      * identified by `head_pending_airdrop_id`.
  final BigInt? numberPendingAirdrops;

    /// *
  ///      * The number of hooks currently in use on this account.
  final BigInt? numberHooksInUse;

    /// *
  ///      * If the account has more than zero hooks in use, the id of the first hook in its
  ///      * doubly-linked list of hooks.
  final BigInt? firstHookId;

    /// *
  ///      * The number of storage slots in use by this account's EVM hooks.
  final BigInt? numberEvmHookStorageSlots;

    /// *
  ///      * The delegated contract address set for this account.
  ///      * &lt;p&gt;
  ///      * If this field is set on the account, anytime a call is made to the account's address
  ///      * (either an EVM call within HSCS or a child call dispatched by CryptoTransfer)
  ///      * the EVM code of the contract referenced by `delegation_address` will be
  ///      * executed in the context of the account.
  final List<int>? delegationAddress;

  const HederaAccount({
    this.accountId,
    this.alias,
    this.key,
    this.expirationSecond,
    this.tinybarBalance,
    this.memo,
    this.deleted,
    this.stakedToMe,
    this.stakePeriodStart,
    this.stakedAccountId,
    this.stakedNodeId,
    this.declineReward,
    this.receiverSigRequired,
    this.headTokenId,
    this.headNftId,
    this.headNftSerialNumber,
    this.numberOwnedNfts,
    this.maxAutoAssociations,
    this.usedAutoAssociations,
    this.numberAssociations,
    this.smartContract,
    this.numberPositiveBalances,
    this.ethereumNonce,
    this.stakeAtStartOfLastRewardedPeriod,
    this.autoRenewAccountId,
    this.autoRenewSeconds,
    this.contractKvPairsNumber,
    this.cryptoAllowances = const [],
    this.approveForAllNftAllowances = const [],
    this.tokenAllowances = const [],
    this.numberTreasuryTitles,
    this.expiredAndPendingRemoval,
    this.firstContractStorageKey,
    this.headPendingAirdropId,
    this.numberPendingAirdrops,
    this.numberHooksInUse,
    this.firstHookId,
    this.numberEvmHookStorageSlots,
    this.delegationAddress,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.string(6),
        ProtoFieldConfig.bool(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.bool(12),
        ProtoFieldConfig.bool(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.int64(16),
        ProtoFieldConfig.int64(17),
        ProtoFieldConfig.int32(18),
        ProtoFieldConfig.int32(19),
        ProtoFieldConfig.int32(20),
        ProtoFieldConfig.bool(21),
        ProtoFieldConfig.int32(22),
        ProtoFieldConfig.int64(23),
        ProtoFieldConfig.int64(24),
        ProtoFieldConfig.message(25),
        ProtoFieldConfig.int64(26),
        ProtoFieldConfig.int32(27),
        ProtoFieldConfig.repeated(
          fieldNumber: 28,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 29,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 30,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint32(31),
        ProtoFieldConfig.bool(32),
        ProtoFieldConfig.bytes(33),
        ProtoFieldConfig.message(34),
        ProtoFieldConfig.uint64(35),
        ProtoFieldConfig.uint64(36),
        ProtoFieldConfig.int64(37),
        ProtoFieldConfig.uint64(38),
        ProtoFieldConfig.bytes(39),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountId,
        alias,
        key,
        expirationSecond,
        tinybarBalance,
        memo,
        deleted,
        stakedToMe,
        stakePeriodStart,
        stakedAccountId,
        stakedNodeId,
        declineReward,
        receiverSigRequired,
        headTokenId,
        headNftId,
        headNftSerialNumber,
        numberOwnedNfts,
        maxAutoAssociations,
        usedAutoAssociations,
        numberAssociations,
        smartContract,
        numberPositiveBalances,
        ethereumNonce,
        stakeAtStartOfLastRewardedPeriod,
        autoRenewAccountId,
        autoRenewSeconds,
        contractKvPairsNumber,
        cryptoAllowances,
        approveForAllNftAllowances,
        tokenAllowances,
        numberTreasuryTitles,
        expiredAndPendingRemoval,
        firstContractStorageKey,
        headPendingAirdropId,
        numberPendingAirdrops,
        numberHooksInUse,
        firstHookId,
        numberEvmHookStorageSlots,
        delegationAddress,
      ];


HederaAccount copyWith(
{proto_basic_types.HederaAccountID? accountId,

List<int>? alias,

proto_basic_types.HederaKey? key,

BigInt? expirationSecond,

BigInt? tinybarBalance,

String? memo,

bool? deleted,

BigInt? stakedToMe,

BigInt? stakePeriodStart,

proto_basic_types.HederaAccountID? stakedAccountId,

BigInt? stakedNodeId,

bool? declineReward,

bool? receiverSigRequired,

proto_basic_types.HederaTokenID? headTokenId,

proto_basic_types.HederaNftID? headNftId,

BigInt? headNftSerialNumber,

BigInt? numberOwnedNfts,

int? maxAutoAssociations,

int? usedAutoAssociations,

int? numberAssociations,

bool? smartContract,

int? numberPositiveBalances,

BigInt? ethereumNonce,

BigInt? stakeAtStartOfLastRewardedPeriod,

proto_basic_types.HederaAccountID? autoRenewAccountId,

BigInt? autoRenewSeconds,

int? contractKvPairsNumber,

List<HederaAccountCryptoAllowance>? cryptoAllowances,

List<HederaAccountApprovalForAllAllowance>? approveForAllNftAllowances,

List<HederaAccountFungibleTokenAllowance>? tokenAllowances,

int? numberTreasuryTitles,

bool? expiredAndPendingRemoval,

List<int>? firstContractStorageKey,

proto_basic_types.HederaPendingAirdropId? headPendingAirdropId,

BigInt? numberPendingAirdrops,

BigInt? numberHooksInUse,

BigInt? firstHookId,

BigInt? numberEvmHookStorageSlots,

List<int>? delegationAddress,

}) {
    return HederaAccount(
accountId: accountId ?? this.accountId,
alias: alias ?? this.alias,
key: key ?? this.key,
expirationSecond: expirationSecond ?? this.expirationSecond,
tinybarBalance: tinybarBalance ?? this.tinybarBalance,
memo: memo ?? this.memo,
deleted: deleted ?? this.deleted,
stakedToMe: stakedToMe ?? this.stakedToMe,
stakePeriodStart: stakePeriodStart ?? this.stakePeriodStart,
stakedAccountId: stakedAccountId ?? this.stakedAccountId,
stakedNodeId: stakedNodeId ?? this.stakedNodeId,
declineReward: declineReward ?? this.declineReward,
receiverSigRequired: receiverSigRequired ?? this.receiverSigRequired,
headTokenId: headTokenId ?? this.headTokenId,
headNftId: headNftId ?? this.headNftId,
headNftSerialNumber: headNftSerialNumber ?? this.headNftSerialNumber,
numberOwnedNfts: numberOwnedNfts ?? this.numberOwnedNfts,
maxAutoAssociations: maxAutoAssociations ?? this.maxAutoAssociations,
usedAutoAssociations: usedAutoAssociations ?? this.usedAutoAssociations,
numberAssociations: numberAssociations ?? this.numberAssociations,
smartContract: smartContract ?? this.smartContract,
numberPositiveBalances: numberPositiveBalances ?? this.numberPositiveBalances,
ethereumNonce: ethereumNonce ?? this.ethereumNonce,
stakeAtStartOfLastRewardedPeriod: stakeAtStartOfLastRewardedPeriod ?? this.stakeAtStartOfLastRewardedPeriod,
autoRenewAccountId: autoRenewAccountId ?? this.autoRenewAccountId,
autoRenewSeconds: autoRenewSeconds ?? this.autoRenewSeconds,
contractKvPairsNumber: contractKvPairsNumber ?? this.contractKvPairsNumber,
cryptoAllowances: cryptoAllowances ?? this.cryptoAllowances,
approveForAllNftAllowances: approveForAllNftAllowances ?? this.approveForAllNftAllowances,
tokenAllowances: tokenAllowances ?? this.tokenAllowances,
numberTreasuryTitles: numberTreasuryTitles ?? this.numberTreasuryTitles,
expiredAndPendingRemoval: expiredAndPendingRemoval ?? this.expiredAndPendingRemoval,
firstContractStorageKey: firstContractStorageKey ?? this.firstContractStorageKey,
headPendingAirdropId: headPendingAirdropId ?? this.headPendingAirdropId,
numberPendingAirdrops: numberPendingAirdrops ?? this.numberPendingAirdrops,
numberHooksInUse: numberHooksInUse ?? this.numberHooksInUse,
firstHookId: firstHookId ?? this.firstHookId,
numberEvmHookStorageSlots: numberEvmHookStorageSlots ?? this.numberEvmHookStorageSlots,
delegationAddress: delegationAddress ?? this.delegationAddress,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'account_id': config.encodeMessage(accountId),
      'alias': config.encodeBinary(alias),
      'key': config.encodeMessage(key),
      'expiration_second': config.encodeBigint(expirationSecond),
      'tinybar_balance': config.encodeBigint(tinybarBalance),
      'memo': memo,
      'deleted': deleted,
      'staked_to_me': config.encodeBigint(stakedToMe),
      'stake_period_start': config.encodeBigint(stakePeriodStart),
      'staked_account_id': config.encodeMessage(stakedAccountId),
      'staked_node_id': config.encodeBigint(stakedNodeId),
      'decline_reward': declineReward,
      'receiver_sig_required': receiverSigRequired,
      'head_token_id': config.encodeMessage(headTokenId),
      'head_nft_id': config.encodeMessage(headNftId),
      'head_nft_serial_number': config.encodeBigint(headNftSerialNumber),
      'number_owned_nfts': config.encodeBigint(numberOwnedNfts),
      'max_auto_associations': maxAutoAssociations,
      'used_auto_associations': usedAutoAssociations,
      'number_associations': numberAssociations,
      'smart_contract': smartContract,
      'number_positive_balances': numberPositiveBalances,
      'ethereum_nonce': config.encodeBigint(ethereumNonce),
      'stake_at_start_of_last_rewarded_period': config.encodeBigint(stakeAtStartOfLastRewardedPeriod),
      'auto_renew_account_id': config.encodeMessage(autoRenewAccountId),
      'auto_renew_seconds': config.encodeBigint(autoRenewSeconds),
      'contract_kv_pairs_number': contractKvPairsNumber,
      'crypto_allowances': cryptoAllowances.map((e) => config.encodeMessage(e)).toList(),
      'approve_for_all_nft_allowances': approveForAllNftAllowances.map((e) => config.encodeMessage(e)).toList(),
      'token_allowances': tokenAllowances.map((e) => config.encodeMessage(e)).toList(),
      'number_treasury_titles': numberTreasuryTitles,
      'expired_and_pending_removal': expiredAndPendingRemoval,
      'first_contract_storage_key': config.encodeBinary(firstContractStorageKey),
      'head_pending_airdrop_id': config.encodeMessage(headPendingAirdropId),
      'number_pending_airdrops': config.encodeBigint(numberPendingAirdrops),
      'number_hooks_in_use': config.encodeBigint(numberHooksInUse),
      'first_hook_id': config.encodeBigint(firstHookId),
      'number_evm_hook_storage_slots': config.encodeBigint(numberEvmHookStorageSlots),
      'delegation_address': config.encodeBinary(delegationAddress),
    };
  }


  factory HederaAccount.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAccount(
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      alias: config.decodeBinary<List<int>?>(json.valueAs('alias', normalizeKeyLookup: config.normalizeKeys)),
      key: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      expirationSecond: json.valueAsBigInt<BigInt?>('expiration_second', normalizeKeyLookup: config.normalizeKeys),
      tinybarBalance: json.valueAsBigInt<BigInt?>('tinybar_balance', normalizeKeyLookup: config.normalizeKeys),
      memo: json.valueAsString<String?>('memo', normalizeKeyLookup: config.normalizeKeys),
      deleted: json.valueAsBool<bool?>('deleted', normalizeKeyLookup: config.normalizeKeys),
      stakedToMe: json.valueAsBigInt<BigInt?>('staked_to_me', normalizeKeyLookup: config.normalizeKeys),
      stakePeriodStart: json.valueAsBigInt<BigInt?>('stake_period_start', normalizeKeyLookup: config.normalizeKeys),
      stakedAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'staked_account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      stakedNodeId: json.valueAsBigInt<BigInt?>('staked_node_id', normalizeKeyLookup: config.normalizeKeys),
      declineReward: json.valueAsBool<bool?>('decline_reward', normalizeKeyLookup: config.normalizeKeys),
      receiverSigRequired: json.valueAsBool<bool?>('receiver_sig_required', normalizeKeyLookup: config.normalizeKeys),
      headTokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'head_token_id',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      headNftId: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'head_nft_id',
        parse: (v) => proto_basic_types.HederaNftID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      headNftSerialNumber: json.valueAsBigInt<BigInt?>('head_nft_serial_number', normalizeKeyLookup: config.normalizeKeys),
      numberOwnedNfts: json.valueAsBigInt<BigInt?>('number_owned_nfts', normalizeKeyLookup: config.normalizeKeys),
      maxAutoAssociations: json.valueAsInt<int?>('max_auto_associations', normalizeKeyLookup: config.normalizeKeys),
      usedAutoAssociations: json.valueAsInt<int?>('used_auto_associations', normalizeKeyLookup: config.normalizeKeys),
      numberAssociations: json.valueAsInt<int?>('number_associations', normalizeKeyLookup: config.normalizeKeys),
      smartContract: json.valueAsBool<bool?>('smart_contract', normalizeKeyLookup: config.normalizeKeys),
      numberPositiveBalances: json.valueAsInt<int?>('number_positive_balances', normalizeKeyLookup: config.normalizeKeys),
      ethereumNonce: json.valueAsBigInt<BigInt?>('ethereum_nonce', normalizeKeyLookup: config.normalizeKeys),
      stakeAtStartOfLastRewardedPeriod: json.valueAsBigInt<BigInt?>('stake_at_start_of_last_rewarded_period', normalizeKeyLookup: config.normalizeKeys),
      autoRenewAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'auto_renew_account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      autoRenewSeconds: json.valueAsBigInt<BigInt?>('auto_renew_seconds', normalizeKeyLookup: config.normalizeKeys),
      contractKvPairsNumber: json.valueAsInt<int?>('contract_kv_pairs_number', normalizeKeyLookup: config.normalizeKeys),
      cryptoAllowances: (json.valueEnsureAsList<dynamic>('crypto_allowances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaAccountCryptoAllowance, Object>(
          value: e,
          parse: (v) => HederaAccountCryptoAllowance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      approveForAllNftAllowances: (json.valueEnsureAsList<dynamic>('approve_for_all_nft_allowances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaAccountApprovalForAllAllowance, Object>(
          value: e,
          parse: (v) => HederaAccountApprovalForAllAllowance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      tokenAllowances: (json.valueEnsureAsList<dynamic>('token_allowances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaAccountFungibleTokenAllowance, Object>(
          value: e,
          parse: (v) => HederaAccountFungibleTokenAllowance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      numberTreasuryTitles: json.valueAsInt<int?>('number_treasury_titles', normalizeKeyLookup: config.normalizeKeys),
      expiredAndPendingRemoval: json.valueAsBool<bool?>('expired_and_pending_removal', normalizeKeyLookup: config.normalizeKeys),
      firstContractStorageKey: config.decodeBinary<List<int>?>(json.valueAs('first_contract_storage_key', normalizeKeyLookup: config.normalizeKeys)),
      headPendingAirdropId: json.valueTo<proto_basic_types.HederaPendingAirdropId?, Object>(
        key: 'head_pending_airdrop_id',
        parse: (v) => proto_basic_types.HederaPendingAirdropId.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      numberPendingAirdrops: json.valueAsBigInt<BigInt?>('number_pending_airdrops', normalizeKeyLookup: config.normalizeKeys),
      numberHooksInUse: json.valueAsBigInt<BigInt?>('number_hooks_in_use', normalizeKeyLookup: config.normalizeKeys),
      firstHookId: json.valueAsBigInt<BigInt?>('first_hook_id', normalizeKeyLookup: config.normalizeKeys),
      numberEvmHookStorageSlots: json.valueAsBigInt<BigInt?>('number_evm_hook_storage_slots', normalizeKeyLookup: config.normalizeKeys),
      delegationAddress: config.decodeBinary<List<int>?>(json.valueAs('delegation_address', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaAccount.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccount(
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      alias: decode.getBytes<List<int>?>(2),
      key: decode.messageTo<proto_basic_types.HederaKey?>(3, (b) => proto_basic_types.HederaKey.deserialize(b)),
      expirationSecond: decode.getBigInt<BigInt?>(4),
      tinybarBalance: decode.getBigInt<BigInt?>(5),
      memo: decode.getString<String?>(6),
      deleted: decode.getBool<bool?>(7),
      stakedToMe: decode.getBigInt<BigInt?>(8),
      stakePeriodStart: decode.getBigInt<BigInt?>(9),
      stakedAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(10, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      stakedNodeId: decode.getBigInt<BigInt?>(11),
      declineReward: decode.getBool<bool?>(12),
      receiverSigRequired: decode.getBool<bool?>(13),
      headTokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(14, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      headNftId: decode.messageTo<proto_basic_types.HederaNftID?>(15, (b) => proto_basic_types.HederaNftID.deserialize(b)),
      headNftSerialNumber: decode.getBigInt<BigInt?>(16),
      numberOwnedNfts: decode.getBigInt<BigInt?>(17),
      maxAutoAssociations: decode.getInt<int?>(18),
      usedAutoAssociations: decode.getInt<int?>(19),
      numberAssociations: decode.getInt<int?>(20),
      smartContract: decode.getBool<bool?>(21),
      numberPositiveBalances: decode.getInt<int?>(22),
      ethereumNonce: decode.getBigInt<BigInt?>(23),
      stakeAtStartOfLastRewardedPeriod: decode.getBigInt<BigInt?>(24),
      autoRenewAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(25, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      autoRenewSeconds: decode.getBigInt<BigInt?>(26),
      contractKvPairsNumber: decode.getInt<int?>(27),
      cryptoAllowances: decode.getListOfBytes(28).map((b) => HederaAccountCryptoAllowance.deserialize(b)).toList(),
      approveForAllNftAllowances: decode.getListOfBytes(29).map((b) => HederaAccountApprovalForAllAllowance.deserialize(b)).toList(),
      tokenAllowances: decode.getListOfBytes(30).map((b) => HederaAccountFungibleTokenAllowance.deserialize(b)).toList(),
      numberTreasuryTitles: decode.getInt<int?>(31),
      expiredAndPendingRemoval: decode.getBool<bool?>(32),
      firstContractStorageKey: decode.getBytes<List<int>?>(33),
      headPendingAirdropId: decode.messageTo<proto_basic_types.HederaPendingAirdropId?>(34, (b) => proto_basic_types.HederaPendingAirdropId.deserialize(b)),
      numberPendingAirdrops: decode.getBigInt<BigInt?>(35),
      numberHooksInUse: decode.getBigInt<BigInt?>(36),
      firstHookId: decode.getBigInt<BigInt?>(37),
      numberEvmHookStorageSlots: decode.getBigInt<BigInt?>(38),
      delegationAddress: decode.getBytes<List<int>?>(39),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAccount;

}


/// *
///  * Permission granted by one account (the "funding" account) to another account
///  * (the "spender" account) that allows the spender to transfer all serial
///  * numbers of a specific non-fungible token (NFT) collection owned by the
///  * funding account.&lt;br/&gt;
///  * This is a broad permission, as it does not matter how many NFTs of the
///  * specified collection the funding account owns, the spender MAY dispose of
///  * any or all of them with this allowance.&lt;br/&gt;
///  * Each token type (typically a collection of NFTs) SHALL require a separate
///  * allowance.&lt;br/&gt;
///  * Allowances for a specific serial number MUST be directly associated with
///  * that specific non-fungible token, rather than the holding account.
///  *
///  * An allowance SHALL NOT transfer any tokens directly, it only permits
///  * transactions signed only by the spender account to transfer any non-fungible
///  * tokens of the specified type owned by the funding account.
class HederaAccountApprovalForAllAllowance extends HederaProtoMessage with Equality {
    /// *
  ///      * The identifier for the token associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This token MUST be a non-fungible/unique token.
  final proto_basic_types.HederaTokenID? tokenId;

    /// *
  ///      * The identifier for the spending account associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This account SHALL be permitted to sign transactions to spend tokens of
  ///      * the associated token type from the funding/allowing account.
  final proto_basic_types.HederaAccountID? spenderId;

  const HederaAccountApprovalForAllAllowance({
    this.tokenId,
    this.spenderId,
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
        spenderId,
      ];


HederaAccountApprovalForAllAllowance copyWith(
{proto_basic_types.HederaTokenID? tokenId,

proto_basic_types.HederaAccountID? spenderId,

}) {
    return HederaAccountApprovalForAllAllowance(
tokenId: tokenId ?? this.tokenId,
spenderId: spenderId ?? this.spenderId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token_id': config.encodeMessage(tokenId),
      'spender_id': config.encodeMessage(spenderId),
    };
  }


  factory HederaAccountApprovalForAllAllowance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAccountApprovalForAllAllowance(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      spenderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaAccountApprovalForAllAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccountApprovalForAllAllowance(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      spenderId: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAccountApprovalForAllAllowance;

}


/// *
///  * Permission granted by one account (the "funding" account) to another account
///  * (the "spender" account) that allows the spender to spend a specified amount
///  * of a specific non-HBAR fungible token from the balance owned by the funding
///  * account.
///  *
///  * An allowance SHALL NOT transfer any tokens directly, it only permits
///  * transactions signed only by the spender account to transfer tokens of the
///  * specified type, up to the amount specified, from the funding account.
///  *
///  * Once the specified amount is spent, the allowance SHALL be consumed and a
///  * new allowance SHALL be required before that spending account may spend
///  * additional tokens from the funding account.
class HederaAccountFungibleTokenAllowance extends HederaProtoMessage with Equality {
    /// *
  ///      * The identifier for the token associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This token MUST be a fungible/common token.
  final proto_basic_types.HederaTokenID? tokenId;

    /// *
  ///      * The identifier for the spending account associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This account SHALL be permitted to sign transactions to spend tokens of
  ///      * the associated token type from the funding/allowing account.&lt;br/&gt;
  ///      * This permission SHALL be limited to no more than the specified `amount`.
  final proto_basic_types.HederaAccountID? spenderId;

    /// * The maximum amount that the spender account may transfer within the
  ///      * scope of this allowance.
  ///      * &lt;p&gt;
  ///      * This allowance SHALL be consumed if any combination of transfers
  ///      * authorized via this allowance meet this value in total.&lt;br/&gt;
  ///      * This value MUST be specified in the smallest units of the relevant token
  ///      * (i.e. 10&lt;sup&gt;-decimals&lt;/sup&gt; whole tokens).
  final BigInt? amount;

  const HederaAccountFungibleTokenAllowance({
    this.tokenId,
    this.spenderId,
    this.amount,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        spenderId,
        amount,
      ];


HederaAccountFungibleTokenAllowance copyWith(
{proto_basic_types.HederaTokenID? tokenId,

proto_basic_types.HederaAccountID? spenderId,

BigInt? amount,

}) {
    return HederaAccountFungibleTokenAllowance(
tokenId: tokenId ?? this.tokenId,
spenderId: spenderId ?? this.spenderId,
amount: amount ?? this.amount,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token_id': config.encodeMessage(tokenId),
      'spender_id': config.encodeMessage(spenderId),
      'amount': config.encodeBigint(amount),
    };
  }


  factory HederaAccountFungibleTokenAllowance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAccountFungibleTokenAllowance(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      spenderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaAccountFungibleTokenAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccountFungibleTokenAllowance(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      spenderId: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      amount: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAccountFungibleTokenAllowance;

}


/// *
///  * Permission granted by one account (the "funding" account) to another account
///  * (the "spender" account) that allows the spender to spend a specified amount
///  * of HBAR owned by the funding account.
///  *
///  * An allowance SHALL NOT transfer any HBAR directly, it only permits
///  * transactions signed only by the spender account to transfer HBAR, up to the
///  * amount specified, from the funding account.
///  *
///  * Once the specified amount is spent, the allowance SHALL be consumed and a
///  * new allowance SHALL be required before that spending account may spend
///  * additional HBAR from the funding account.
class HederaAccountCryptoAllowance extends HederaProtoMessage with Equality {
    /// *
  ///      * The identifier for the spending account associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This account SHALL be permitted to sign transactions to spend HBAR from
  ///      * the funding/allowing account.&lt;br/&gt;
  ///      * This permission SHALL be limited to no more than the specified `amount`.
  final proto_basic_types.HederaAccountID? spenderId;

    /// * The maximum amount that the spender account may transfer within the
  ///      * scope of this allowance.
  ///      * &lt;p&gt;
  ///      * This allowance SHALL be consumed if any combination of transfers
  ///      * authorized via this allowance meet this value in total.&lt;br/&gt;
  ///      * This value MUST be specified in tinybar (i.e. 10&lt;sup&gt;-8&lt;/sup&gt; HBAR).
  final BigInt? amount;

  const HederaAccountCryptoAllowance({
    this.spenderId,
    this.amount,
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
        spenderId,
        amount,
      ];


HederaAccountCryptoAllowance copyWith(
{proto_basic_types.HederaAccountID? spenderId,

BigInt? amount,

}) {
    return HederaAccountCryptoAllowance(
spenderId: spenderId ?? this.spenderId,
amount: amount ?? this.amount,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'spender_id': config.encodeMessage(spenderId),
      'amount': config.encodeBigint(amount),
    };
  }


  factory HederaAccountCryptoAllowance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAccountCryptoAllowance(
      spenderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaAccountCryptoAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccountCryptoAllowance(
      spenderId: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      amount: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoAccountCryptoAllowance;

}



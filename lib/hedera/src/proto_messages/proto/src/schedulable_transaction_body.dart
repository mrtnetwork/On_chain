import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_call.dart" as proto_contract_call;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_create.dart" as proto_contract_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_update.dart" as proto_contract_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_delete.dart" as proto_contract_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_create.dart" as proto_crypto_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_delete.dart" as proto_crypto_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_transfer.dart" as proto_crypto_transfer;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_update.dart" as proto_crypto_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_append.dart" as proto_file_append;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_create.dart" as proto_file_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_delete.dart" as proto_file_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_update.dart" as proto_file_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/system_delete.dart" as proto_system_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/system_undelete.dart" as proto_system_undelete;
import "package:on_chain/hedera/src/proto_messages/proto/src/freeze.dart" as proto_freeze;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_create_topic.dart" as proto_consensus_create_topic;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_update_topic.dart" as proto_consensus_update_topic;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_delete_topic.dart" as proto_consensus_delete_topic;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_submit_message.dart" as proto_consensus_submit_message;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_create.dart" as proto_token_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_freeze_account.dart" as proto_token_freeze_account;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_unfreeze_account.dart" as proto_token_unfreeze_account;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_grant_kyc.dart" as proto_token_grant_kyc;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_revoke_kyc.dart" as proto_token_revoke_kyc;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_delete.dart" as proto_token_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_update.dart" as proto_token_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_mint.dart" as proto_token_mint;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_burn.dart" as proto_token_burn;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_wipe_account.dart" as proto_token_wipe_account;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_associate.dart" as proto_token_associate;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_dissociate.dart" as proto_token_dissociate;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedule_delete.dart" as proto_schedule_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_pause.dart" as proto_token_pause;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_unpause.dart" as proto_token_unpause;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_approve_allowance.dart" as proto_crypto_approve_allowance;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_delete_allowance.dart" as proto_crypto_delete_allowance;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_fee_schedule_update.dart" as proto_token_fee_schedule_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/util_prng.dart" as proto_util_prng;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_update_nfts.dart" as proto_token_update_nfts;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/node_create.dart" as com_hedera_hapi_node_addressbook_node_create;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/node_update.dart" as com_hedera_hapi_node_addressbook_node_update;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/node_delete.dart" as com_hedera_hapi_node_addressbook_node_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_reject.dart" as proto_token_reject;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_cancel_airdrop.dart" as proto_token_cancel_airdrop;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_claim_airdrop.dart" as proto_token_claim_airdrop;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_airdrop.dart" as proto_token_airdrop;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_node_create.dart" as com_hedera_hapi_node_addressbook_registered_node_create;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_node_update.dart" as com_hedera_hapi_node_addressbook_registered_node_update;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_node_delete.dart" as com_hedera_hapi_node_addressbook_registered_node_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart" as proto_custom_fees;

/// *
///  * # Schedulable Transaction Body
///  * A message that replicates the `TransactionBody` message, with slight
///  * changes to exclude fields that cannot be scheduled via a `scheduleCreate`
///  * transaction.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.scheduled"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A schedulable transaction.
///  *
///  * The network configuration `scheduling.whitelist` limits which of these
///  * transaction types may actually be scheduled. As of version `0.50.0` of the
///  * consensus node software this list contains only `CryptoTransfer`,
///  * `ConsensusSubmitMessage`, `TokenBurn`, `TokenMint`,
///  * and `CryptoApproveAllowance`.
class HederaSchedulableTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A limit for the transaction fee the client is willing to pay.
  ///      * &lt;p&gt;
  ///      * The network SHALL NOT charge fees greater than this value.
  final BigInt? transactionFee;

    /// *
  ///      * A short description of the schedulable transaction.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

    /// *
  ///          * Call a function defined on a smart contract.
  final proto_contract_call.HederaContractCallTransactionBody? contractCall;

    /// *
  ///          * Create a smart contract.
  final proto_contract_create.HederaContractCreateTransactionBody? contractCreateInstance;

    /// *
  ///          * Update a smart contract.
  final proto_contract_update.HederaContractUpdateTransactionBody? contractUpdateInstance;

    /// *
  ///          * Delete a smart contract and transfer remaining balance
  ///          * to a specified account.
  final proto_contract_delete.HederaContractDeleteTransactionBody? contractDeleteInstance;

    /// *
  ///          * Create a new Hedera account.
  final proto_crypto_create.HederaCryptoCreateTransactionBody? cryptoCreateAccount;

    /// *
  ///          * Delete an Hedera account.&lt;br/&gt;
  ///          * This will mark the account as deleted, and transfer all remaining
  ///          * HBAR to a receiver account.
  final proto_crypto_delete.HederaCryptoDeleteTransactionBody? cryptoDelete;

    /// *
  ///          * Transfer HBAR between accounts.
  final proto_crypto_transfer.HederaCryptoTransferTransactionBody? cryptoTransfer;

    /// *
  ///          * Modify an Hedera account.
  final proto_crypto_update.HederaCryptoUpdateTransactionBody? cryptoUpdateAccount;

    /// *
  ///          * Append data to the end of a file.
  final proto_file_append.HederaFileAppendTransactionBody? fileAppend;

    /// *
  ///          * Create a new file.
  final proto_file_create.HederaFileCreateTransactionBody? fileCreate;

    /// *
  ///          * Delete a file.&lt;br/&gt;
  ///          * This will remove the content of the file, and mark the file as
  ///          * deleted.
  final proto_file_delete.HederaFileDeleteTransactionBody? fileDelete;

    /// *
  ///          * Modify a file.&lt;br/&gt;
  ///          * This may modify any metadata, and/or _replace_ the content.
  final proto_file_update.HederaFileUpdateTransactionBody? fileUpdate;

    /// *
  ///          * Delete a file as an Hedera administrative function.&lt;br/&gt;
  ///          * This is a privileged operation.
  final proto_system_delete.HederaSystemDeleteTransactionBody? systemDelete;

    /// *
  ///          * Restore a file deleted via `systemDelete`.&lt;br/&gt;
  ///          * This is a privileged operation.
  final proto_system_undelete.HederaSystemUndeleteTransactionBody? systemUndelete;

    /// *
  ///          * Freeze the network.&lt;br/&gt;
  ///          * This is actually several possible operations, and the caller
  ///          * should examine the "freeze service" for more detail.&lt;br/&gt;
  ///          * This is a privileged operation.
  final proto_freeze.HederaFreezeTransactionBody? freeze;

    /// *
  ///          * Create a topic.
  final proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody? consensusCreateTopic;

    /// *
  ///          * Update a topic.
  final proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody? consensusUpdateTopic;

    /// *
  ///          * Delete a topic.
  final proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody? consensusDeleteTopic;

    /// *
  ///          * Submit a message to a topic.&lt;br/&gt;
  ///          * A message may be "chunked", and submitted in parts, if the total
  ///          * message size exceeds the limit for a single transaction.
  final proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody? consensusSubmitMessage;

    /// *
  ///          * Create a new Hedera token.
  final proto_token_create.HederaTokenCreateTransactionBody? tokenCreation;

    /// *
  ///          * Freeze an account with respect to a token.&lt;br/&gt;
  ///          * A frozen account cannot transact in that token until unfrozen.
  final proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody? tokenFreeze;

    /// *
  ///          * Unfreeze an account with respect to a token.
  final proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody? tokenUnfreeze;

    /// *
  ///          * Grant KYC to an account with respect to a token.&lt;br/&gt;
  ///          * KYC is generally a "know your customer" assertion that a
  ///          * responsible entity has sufficient information to positively
  ///          * identify the account holder to relevant authorities.
  final proto_token_grant_kyc.HederaTokenGrantKycTransactionBody? tokenGrantKyc;

    /// *
  ///          * Revoke KYC from an account with respect to a token.
  final proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody? tokenRevokeKyc;

    /// *
  ///          * Deletes an Hedera token.&lt;br/&gt;
  ///          * The token will be marked deleted.
  final proto_token_delete.HederaTokenDeleteTransactionBody? tokenDeletion;

    /// *
  ///          * Update an Hedera token.&lt;br/&gt;
  ///          * Depending on what fields are to be modified, the signature
  ///          * requirements will vary. See `TokenUpdateTransactionBody` for
  ///          * further detail.
  final proto_token_update.HederaTokenUpdateTransactionBody? tokenUpdate;

    /// *
  ///          * Mint new tokens.&lt;br/&gt;
  ///          * All minted tokens will be delivered to the treasury account for
  ///          * the token type. The "mint key" for the token must sign this
  ///          * transaction.
  final proto_token_mint.HederaTokenMintTransactionBody? tokenMint;

    /// *
  ///          * Burn tokens from the treasury account.&lt;br/&gt;
  ///          * The "burn key" for the token must sign this transaction.
  final proto_token_burn.HederaTokenBurnTransactionBody? tokenBurn;

    /// *
  ///          * Wipe tokens from an account.&lt;br/&gt;
  ///          * This will remove a specified amount of fungible/common tokens or
  ///          * a specified list of non-fungible/unique serial numbered tokens
  ///          * of a given token type from an Hedera account. The removed tokens
  ///          * are _burned_ as if by a `tokenBurn` transaction.&lt;br/&gt;
  ///          * The "wipe key" for the token must sign this transaction.
  final proto_token_wipe_account.HederaTokenWipeAccountTransactionBody? tokenWipe;

    /// *
  ///          * Associate tokens to an account.
  final proto_token_associate.HederaTokenAssociateTransactionBody? tokenAssociate;

    /// *
  ///          * Dissociate tokens from an account.
  final proto_token_dissociate.HederaTokenDissociateTransactionBody? tokenDissociate;

    /// *
  ///          * Delete a schedule.&lt;br/&gt;
  ///          * The schedule will be marked as deleted.
  final proto_schedule_delete.HederaScheduleDeleteTransactionBody? scheduleDelete;

    /// *
  ///          * Pause a Token.&lt;br/&gt;
  ///          * This transaction must be signed by the "pause key" for the token.
  final proto_token_pause.HederaTokenPauseTransactionBody? tokenPause;

    /// *
  ///          * Unpause a Token.&lt;br/&gt;
  ///          * This transaction must be signed by the "pause key" for the token.
  final proto_token_unpause.HederaTokenUnpauseTransactionBody? tokenUnpause;

    /// *
  ///          * Add one or more approved allowances for spenders to transfer the
  ///          * paying account's hbar or tokens.
  final proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody? cryptoApproveAllowance;

    /// *
  ///          * Delete one or more approvals for spenders to transfer the
  ///          * paying account's hbar or tokens.
  final proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody? cryptoDeleteAllowance;

    /// *
  ///          * Update the custom fee schedule for a token.&lt;br/&gt;
  ///          * This transaction must be signed by the "fee schedule key"
  ///          * for the token.
  final proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody? tokenFeeScheduleUpdate;

    /// *
  ///          * Provide a deterministic pseudorandom number based on network state.
  final proto_util_prng.HederaUtilPrngTransactionBody? utilPrng;

    /// *
  ///          * Update one or more non-fungible/unique tokens.&lt;br/&gt;
  ///          * This will update metadata for one or more serial numbers within
  ///          * a collection (token type).
  final proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody? tokenUpdateNfts;

    /// *
  ///          * Create a new node in the network address book.&lt;br/&gt;
  ///          * This is a privileged operation.
  final com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody? nodeCreate;

    /// *
  ///          * Update a node in the network address book.&lt;br/&gt;
  ///          * This is a privileged operation.
  final com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody? nodeUpdate;

    /// *
  ///          * Delete a node from the network address book.&lt;br/&gt;
  ///          * This will mark the node as deleted.&lt;br/&gt;
  ///          * This is a privileged operation.
  final com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody? nodeDelete;

    /// *
  ///          * "Reject" undesired tokens.&lt;br/&gt;
  ///          * This transaction will transfer one or more tokens or token
  ///          * balances held by the requesting account to the treasury
  ///          * for each token type.
  ///          * &lt;p&gt;
  ///          * Each transfer MUST be one of the following:
  ///          * &lt;ul&gt;
  ///          *   &lt;li&gt;A single non-fungible/unique token.&lt;/li&gt;
  ///          *   &lt;li&gt;The full balance held for a fungible/common
  ///          *       token type.&lt;/li&gt;
  ///          * &lt;/ul&gt;
  ///          * When complete, the requesting account SHALL NOT hold the
  ///          * rejected tokens.&lt;br/&gt;
  ///          * Custom fees and royalties defined for the tokens rejected
  ///          * SHALL NOT be charged for this transaction.
  final proto_token_reject.HederaTokenRejectTransactionBody? tokenReject;

    /// *
  ///          * Cancel an "airdrop".&lt;br/&gt;
  ///          * This transaction cancels a pending airdrop for one or more
  ///          * recipients.
  ///          * &lt;p&gt;
  ///          * The airdrop(s) to cancel MUST be pending, and not claimed.&lt;br/&gt;
  final proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody? tokenCancelAirdrop;

    /// *
  ///          * Claim an "airdrop".
  ///          * This transaction "claims" one or more pending "airdrops".
  ///          * &lt;p&gt;
  ///          * The airdrop(s) to claim MUST be pending, and not
  ///          * already claimed.&lt;br/&gt;
  final proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody? tokenClaimAirdrop;

    /// *
  ///          * Send an "airdrop" of tokens to one or more recipients.
  ///          * &lt;p&gt;
  ///          * This transaction unilaterally "gifts" tokens by transferring them
  ///          * from a "sender" account to the "recipient" account(s). If any
  ///          * recipient is not already associated to the token to airdrop, or
  ///          * has set a "reciever signature required" flag, then that recipient
  ///          * is recorded as a "pending" airdrop which must be "claimed".  All
  ///          * other recipients receive the "airdropped" tokens immediately.
  final proto_token_airdrop.HederaTokenAirdropTransactionBody? tokenAirdrop;

    /// *
  ///          * Create a new registered node in the network address book.
  final com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody? registeredNodeCreate;

    /// *
  ///          * Update a registered node in the network address book.
  final com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody? registeredNodeUpdate;

    /// *
  ///          * Delete a registered node from the network address book.
  final com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody? registeredNodeDelete;

    /// *
  ///       * A list of maximum custom fees that the users are willing to pay.
  ///       * &lt;p&gt;
  ///       * This field is OPTIONAL.&lt;br/&gt;
  ///       * If left empty, the users are accepting to pay any custom fee.&lt;br/&gt;
  ///       * If used with a transaction type that does not support custom fee limits, the transaction will fail.
  final List<proto_custom_fees.HederaCustomFeeLimit> maxCustomFees;

  const HederaSchedulableTransactionBody({
    this.transactionFee,
    this.memo,
    this.contractCall,
    this.contractCreateInstance,
    this.contractUpdateInstance,
    this.contractDeleteInstance,
    this.cryptoCreateAccount,
    this.cryptoDelete,
    this.cryptoTransfer,
    this.cryptoUpdateAccount,
    this.fileAppend,
    this.fileCreate,
    this.fileDelete,
    this.fileUpdate,
    this.systemDelete,
    this.systemUndelete,
    this.freeze,
    this.consensusCreateTopic,
    this.consensusUpdateTopic,
    this.consensusDeleteTopic,
    this.consensusSubmitMessage,
    this.tokenCreation,
    this.tokenFreeze,
    this.tokenUnfreeze,
    this.tokenGrantKyc,
    this.tokenRevokeKyc,
    this.tokenDeletion,
    this.tokenUpdate,
    this.tokenMint,
    this.tokenBurn,
    this.tokenWipe,
    this.tokenAssociate,
    this.tokenDissociate,
    this.scheduleDelete,
    this.tokenPause,
    this.tokenUnpause,
    this.cryptoApproveAllowance,
    this.cryptoDeleteAllowance,
    this.tokenFeeScheduleUpdate,
    this.utilPrng,
    this.tokenUpdateNfts,
    this.nodeCreate,
    this.nodeUpdate,
    this.nodeDelete,
    this.tokenReject,
    this.tokenCancelAirdrop,
    this.tokenClaimAirdrop,
    this.tokenAirdrop,
    this.registeredNodeCreate,
    this.registeredNodeUpdate,
    this.registeredNodeDelete,
    this.maxCustomFees = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.message(16),
        ProtoFieldConfig.message(17),
        ProtoFieldConfig.message(18),
        ProtoFieldConfig.message(19),
        ProtoFieldConfig.message(20),
        ProtoFieldConfig.message(21),
        ProtoFieldConfig.message(22),
        ProtoFieldConfig.message(23),
        ProtoFieldConfig.message(24),
        ProtoFieldConfig.message(25),
        ProtoFieldConfig.message(26),
        ProtoFieldConfig.message(27),
        ProtoFieldConfig.message(28),
        ProtoFieldConfig.message(29),
        ProtoFieldConfig.message(30),
        ProtoFieldConfig.message(31),
        ProtoFieldConfig.message(32),
        ProtoFieldConfig.message(33),
        ProtoFieldConfig.message(34),
        ProtoFieldConfig.message(35),
        ProtoFieldConfig.message(36),
        ProtoFieldConfig.message(37),
        ProtoFieldConfig.message(38),
        ProtoFieldConfig.message(39),
        ProtoFieldConfig.message(40),
        ProtoFieldConfig.message(41),
        ProtoFieldConfig.message(42),
        ProtoFieldConfig.message(43),
        ProtoFieldConfig.message(44),
        ProtoFieldConfig.message(45),
        ProtoFieldConfig.message(46),
        ProtoFieldConfig.message(47),
        ProtoFieldConfig.message(48),
        ProtoFieldConfig.message(49),
        ProtoFieldConfig.message(50),
        ProtoFieldConfig.message(51),
        ProtoFieldConfig.repeated(
          fieldNumber: 1001,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transactionFee,
        memo,
        contractCall,
        contractCreateInstance,
        contractUpdateInstance,
        contractDeleteInstance,
        cryptoCreateAccount,
        cryptoDelete,
        cryptoTransfer,
        cryptoUpdateAccount,
        fileAppend,
        fileCreate,
        fileDelete,
        fileUpdate,
        systemDelete,
        systemUndelete,
        freeze,
        consensusCreateTopic,
        consensusUpdateTopic,
        consensusDeleteTopic,
        consensusSubmitMessage,
        tokenCreation,
        tokenFreeze,
        tokenUnfreeze,
        tokenGrantKyc,
        tokenRevokeKyc,
        tokenDeletion,
        tokenUpdate,
        tokenMint,
        tokenBurn,
        tokenWipe,
        tokenAssociate,
        tokenDissociate,
        scheduleDelete,
        tokenPause,
        tokenUnpause,
        cryptoApproveAllowance,
        cryptoDeleteAllowance,
        tokenFeeScheduleUpdate,
        utilPrng,
        tokenUpdateNfts,
        nodeCreate,
        nodeUpdate,
        nodeDelete,
        tokenReject,
        tokenCancelAirdrop,
        tokenClaimAirdrop,
        tokenAirdrop,
        registeredNodeCreate,
        registeredNodeUpdate,
        registeredNodeDelete,
        maxCustomFees,
      ];


HederaSchedulableTransactionBody copyWith(
{BigInt? transactionFee,

String? memo,

proto_contract_call.HederaContractCallTransactionBody? contractCall,

proto_contract_create.HederaContractCreateTransactionBody? contractCreateInstance,

proto_contract_update.HederaContractUpdateTransactionBody? contractUpdateInstance,

proto_contract_delete.HederaContractDeleteTransactionBody? contractDeleteInstance,

proto_crypto_create.HederaCryptoCreateTransactionBody? cryptoCreateAccount,

proto_crypto_delete.HederaCryptoDeleteTransactionBody? cryptoDelete,

proto_crypto_transfer.HederaCryptoTransferTransactionBody? cryptoTransfer,

proto_crypto_update.HederaCryptoUpdateTransactionBody? cryptoUpdateAccount,

proto_file_append.HederaFileAppendTransactionBody? fileAppend,

proto_file_create.HederaFileCreateTransactionBody? fileCreate,

proto_file_delete.HederaFileDeleteTransactionBody? fileDelete,

proto_file_update.HederaFileUpdateTransactionBody? fileUpdate,

proto_system_delete.HederaSystemDeleteTransactionBody? systemDelete,

proto_system_undelete.HederaSystemUndeleteTransactionBody? systemUndelete,

proto_freeze.HederaFreezeTransactionBody? freeze,

proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody? consensusCreateTopic,

proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody? consensusUpdateTopic,

proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody? consensusDeleteTopic,

proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody? consensusSubmitMessage,

proto_token_create.HederaTokenCreateTransactionBody? tokenCreation,

proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody? tokenFreeze,

proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody? tokenUnfreeze,

proto_token_grant_kyc.HederaTokenGrantKycTransactionBody? tokenGrantKyc,

proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody? tokenRevokeKyc,

proto_token_delete.HederaTokenDeleteTransactionBody? tokenDeletion,

proto_token_update.HederaTokenUpdateTransactionBody? tokenUpdate,

proto_token_mint.HederaTokenMintTransactionBody? tokenMint,

proto_token_burn.HederaTokenBurnTransactionBody? tokenBurn,

proto_token_wipe_account.HederaTokenWipeAccountTransactionBody? tokenWipe,

proto_token_associate.HederaTokenAssociateTransactionBody? tokenAssociate,

proto_token_dissociate.HederaTokenDissociateTransactionBody? tokenDissociate,

proto_schedule_delete.HederaScheduleDeleteTransactionBody? scheduleDelete,

proto_token_pause.HederaTokenPauseTransactionBody? tokenPause,

proto_token_unpause.HederaTokenUnpauseTransactionBody? tokenUnpause,

proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody? cryptoApproveAllowance,

proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody? cryptoDeleteAllowance,

proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody? tokenFeeScheduleUpdate,

proto_util_prng.HederaUtilPrngTransactionBody? utilPrng,

proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody? tokenUpdateNfts,

com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody? nodeCreate,

com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody? nodeUpdate,

com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody? nodeDelete,

proto_token_reject.HederaTokenRejectTransactionBody? tokenReject,

proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody? tokenCancelAirdrop,

proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody? tokenClaimAirdrop,

proto_token_airdrop.HederaTokenAirdropTransactionBody? tokenAirdrop,

com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody? registeredNodeCreate,

com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody? registeredNodeUpdate,

com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody? registeredNodeDelete,

List<proto_custom_fees.HederaCustomFeeLimit>? maxCustomFees,

}) {
    return HederaSchedulableTransactionBody(
transactionFee: transactionFee ?? this.transactionFee,
memo: memo ?? this.memo,
contractCall: contractCall ?? this.contractCall,
contractCreateInstance: contractCreateInstance ?? this.contractCreateInstance,
contractUpdateInstance: contractUpdateInstance ?? this.contractUpdateInstance,
contractDeleteInstance: contractDeleteInstance ?? this.contractDeleteInstance,
cryptoCreateAccount: cryptoCreateAccount ?? this.cryptoCreateAccount,
cryptoDelete: cryptoDelete ?? this.cryptoDelete,
cryptoTransfer: cryptoTransfer ?? this.cryptoTransfer,
cryptoUpdateAccount: cryptoUpdateAccount ?? this.cryptoUpdateAccount,
fileAppend: fileAppend ?? this.fileAppend,
fileCreate: fileCreate ?? this.fileCreate,
fileDelete: fileDelete ?? this.fileDelete,
fileUpdate: fileUpdate ?? this.fileUpdate,
systemDelete: systemDelete ?? this.systemDelete,
systemUndelete: systemUndelete ?? this.systemUndelete,
freeze: freeze ?? this.freeze,
consensusCreateTopic: consensusCreateTopic ?? this.consensusCreateTopic,
consensusUpdateTopic: consensusUpdateTopic ?? this.consensusUpdateTopic,
consensusDeleteTopic: consensusDeleteTopic ?? this.consensusDeleteTopic,
consensusSubmitMessage: consensusSubmitMessage ?? this.consensusSubmitMessage,
tokenCreation: tokenCreation ?? this.tokenCreation,
tokenFreeze: tokenFreeze ?? this.tokenFreeze,
tokenUnfreeze: tokenUnfreeze ?? this.tokenUnfreeze,
tokenGrantKyc: tokenGrantKyc ?? this.tokenGrantKyc,
tokenRevokeKyc: tokenRevokeKyc ?? this.tokenRevokeKyc,
tokenDeletion: tokenDeletion ?? this.tokenDeletion,
tokenUpdate: tokenUpdate ?? this.tokenUpdate,
tokenMint: tokenMint ?? this.tokenMint,
tokenBurn: tokenBurn ?? this.tokenBurn,
tokenWipe: tokenWipe ?? this.tokenWipe,
tokenAssociate: tokenAssociate ?? this.tokenAssociate,
tokenDissociate: tokenDissociate ?? this.tokenDissociate,
scheduleDelete: scheduleDelete ?? this.scheduleDelete,
tokenPause: tokenPause ?? this.tokenPause,
tokenUnpause: tokenUnpause ?? this.tokenUnpause,
cryptoApproveAllowance: cryptoApproveAllowance ?? this.cryptoApproveAllowance,
cryptoDeleteAllowance: cryptoDeleteAllowance ?? this.cryptoDeleteAllowance,
tokenFeeScheduleUpdate: tokenFeeScheduleUpdate ?? this.tokenFeeScheduleUpdate,
utilPrng: utilPrng ?? this.utilPrng,
tokenUpdateNfts: tokenUpdateNfts ?? this.tokenUpdateNfts,
nodeCreate: nodeCreate ?? this.nodeCreate,
nodeUpdate: nodeUpdate ?? this.nodeUpdate,
nodeDelete: nodeDelete ?? this.nodeDelete,
tokenReject: tokenReject ?? this.tokenReject,
tokenCancelAirdrop: tokenCancelAirdrop ?? this.tokenCancelAirdrop,
tokenClaimAirdrop: tokenClaimAirdrop ?? this.tokenClaimAirdrop,
tokenAirdrop: tokenAirdrop ?? this.tokenAirdrop,
registeredNodeCreate: registeredNodeCreate ?? this.registeredNodeCreate,
registeredNodeUpdate: registeredNodeUpdate ?? this.registeredNodeUpdate,
registeredNodeDelete: registeredNodeDelete ?? this.registeredNodeDelete,
maxCustomFees: maxCustomFees ?? this.maxCustomFees,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transactionFee': config.encodeBigint(transactionFee),
      'memo': memo,
      'contractCall': config.encodeMessage(contractCall),
      'contractCreateInstance': config.encodeMessage(contractCreateInstance),
      'contractUpdateInstance': config.encodeMessage(contractUpdateInstance),
      'contractDeleteInstance': config.encodeMessage(contractDeleteInstance),
      'cryptoCreateAccount': config.encodeMessage(cryptoCreateAccount),
      'cryptoDelete': config.encodeMessage(cryptoDelete),
      'cryptoTransfer': config.encodeMessage(cryptoTransfer),
      'cryptoUpdateAccount': config.encodeMessage(cryptoUpdateAccount),
      'fileAppend': config.encodeMessage(fileAppend),
      'fileCreate': config.encodeMessage(fileCreate),
      'fileDelete': config.encodeMessage(fileDelete),
      'fileUpdate': config.encodeMessage(fileUpdate),
      'systemDelete': config.encodeMessage(systemDelete),
      'systemUndelete': config.encodeMessage(systemUndelete),
      'freeze': config.encodeMessage(freeze),
      'consensusCreateTopic': config.encodeMessage(consensusCreateTopic),
      'consensusUpdateTopic': config.encodeMessage(consensusUpdateTopic),
      'consensusDeleteTopic': config.encodeMessage(consensusDeleteTopic),
      'consensusSubmitMessage': config.encodeMessage(consensusSubmitMessage),
      'tokenCreation': config.encodeMessage(tokenCreation),
      'tokenFreeze': config.encodeMessage(tokenFreeze),
      'tokenUnfreeze': config.encodeMessage(tokenUnfreeze),
      'tokenGrantKyc': config.encodeMessage(tokenGrantKyc),
      'tokenRevokeKyc': config.encodeMessage(tokenRevokeKyc),
      'tokenDeletion': config.encodeMessage(tokenDeletion),
      'tokenUpdate': config.encodeMessage(tokenUpdate),
      'tokenMint': config.encodeMessage(tokenMint),
      'tokenBurn': config.encodeMessage(tokenBurn),
      'tokenWipe': config.encodeMessage(tokenWipe),
      'tokenAssociate': config.encodeMessage(tokenAssociate),
      'tokenDissociate': config.encodeMessage(tokenDissociate),
      'scheduleDelete': config.encodeMessage(scheduleDelete),
      'token_pause': config.encodeMessage(tokenPause),
      'token_unpause': config.encodeMessage(tokenUnpause),
      'cryptoApproveAllowance': config.encodeMessage(cryptoApproveAllowance),
      'cryptoDeleteAllowance': config.encodeMessage(cryptoDeleteAllowance),
      'token_fee_schedule_update': config.encodeMessage(tokenFeeScheduleUpdate),
      'util_prng': config.encodeMessage(utilPrng),
      'token_update_nfts': config.encodeMessage(tokenUpdateNfts),
      'nodeCreate': config.encodeMessage(nodeCreate),
      'nodeUpdate': config.encodeMessage(nodeUpdate),
      'nodeDelete': config.encodeMessage(nodeDelete),
      'tokenReject': config.encodeMessage(tokenReject),
      'tokenCancelAirdrop': config.encodeMessage(tokenCancelAirdrop),
      'tokenClaimAirdrop': config.encodeMessage(tokenClaimAirdrop),
      'tokenAirdrop': config.encodeMessage(tokenAirdrop),
      'registeredNodeCreate': config.encodeMessage(registeredNodeCreate),
      'registeredNodeUpdate': config.encodeMessage(registeredNodeUpdate),
      'registeredNodeDelete': config.encodeMessage(registeredNodeDelete),
      'max_custom_fees': maxCustomFees.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaSchedulableTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSchedulableTransactionBody(
      transactionFee: json.valueAsBigInt<BigInt?>('transactionFee', normalizeKeyLookup: config.normalizeKeys),
      memo: json.valueAsString<String?>('memo', normalizeKeyLookup: config.normalizeKeys),
      contractCall: json.valueTo<proto_contract_call.HederaContractCallTransactionBody?, Object>(
        key: 'contractCall',
        parse: (v) => proto_contract_call.HederaContractCallTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contractCreateInstance: json.valueTo<proto_contract_create.HederaContractCreateTransactionBody?, Object>(
        key: 'contractCreateInstance',
        parse: (v) => proto_contract_create.HederaContractCreateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contractUpdateInstance: json.valueTo<proto_contract_update.HederaContractUpdateTransactionBody?, Object>(
        key: 'contractUpdateInstance',
        parse: (v) => proto_contract_update.HederaContractUpdateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contractDeleteInstance: json.valueTo<proto_contract_delete.HederaContractDeleteTransactionBody?, Object>(
        key: 'contractDeleteInstance',
        parse: (v) => proto_contract_delete.HederaContractDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      cryptoCreateAccount: json.valueTo<proto_crypto_create.HederaCryptoCreateTransactionBody?, Object>(
        key: 'cryptoCreateAccount',
        parse: (v) => proto_crypto_create.HederaCryptoCreateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      cryptoDelete: json.valueTo<proto_crypto_delete.HederaCryptoDeleteTransactionBody?, Object>(
        key: 'cryptoDelete',
        parse: (v) => proto_crypto_delete.HederaCryptoDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      cryptoTransfer: json.valueTo<proto_crypto_transfer.HederaCryptoTransferTransactionBody?, Object>(
        key: 'cryptoTransfer',
        parse: (v) => proto_crypto_transfer.HederaCryptoTransferTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      cryptoUpdateAccount: json.valueTo<proto_crypto_update.HederaCryptoUpdateTransactionBody?, Object>(
        key: 'cryptoUpdateAccount',
        parse: (v) => proto_crypto_update.HederaCryptoUpdateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fileAppend: json.valueTo<proto_file_append.HederaFileAppendTransactionBody?, Object>(
        key: 'fileAppend',
        parse: (v) => proto_file_append.HederaFileAppendTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fileCreate: json.valueTo<proto_file_create.HederaFileCreateTransactionBody?, Object>(
        key: 'fileCreate',
        parse: (v) => proto_file_create.HederaFileCreateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fileDelete: json.valueTo<proto_file_delete.HederaFileDeleteTransactionBody?, Object>(
        key: 'fileDelete',
        parse: (v) => proto_file_delete.HederaFileDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      fileUpdate: json.valueTo<proto_file_update.HederaFileUpdateTransactionBody?, Object>(
        key: 'fileUpdate',
        parse: (v) => proto_file_update.HederaFileUpdateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      systemDelete: json.valueTo<proto_system_delete.HederaSystemDeleteTransactionBody?, Object>(
        key: 'systemDelete',
        parse: (v) => proto_system_delete.HederaSystemDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      systemUndelete: json.valueTo<proto_system_undelete.HederaSystemUndeleteTransactionBody?, Object>(
        key: 'systemUndelete',
        parse: (v) => proto_system_undelete.HederaSystemUndeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      freeze: json.valueTo<proto_freeze.HederaFreezeTransactionBody?, Object>(
        key: 'freeze',
        parse: (v) => proto_freeze.HederaFreezeTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      consensusCreateTopic: json.valueTo<proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody?, Object>(
        key: 'consensusCreateTopic',
        parse: (v) => proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      consensusUpdateTopic: json.valueTo<proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody?, Object>(
        key: 'consensusUpdateTopic',
        parse: (v) => proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      consensusDeleteTopic: json.valueTo<proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody?, Object>(
        key: 'consensusDeleteTopic',
        parse: (v) => proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      consensusSubmitMessage: json.valueTo<proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody?, Object>(
        key: 'consensusSubmitMessage',
        parse: (v) => proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenCreation: json.valueTo<proto_token_create.HederaTokenCreateTransactionBody?, Object>(
        key: 'tokenCreation',
        parse: (v) => proto_token_create.HederaTokenCreateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenFreeze: json.valueTo<proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody?, Object>(
        key: 'tokenFreeze',
        parse: (v) => proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenUnfreeze: json.valueTo<proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody?, Object>(
        key: 'tokenUnfreeze',
        parse: (v) => proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenGrantKyc: json.valueTo<proto_token_grant_kyc.HederaTokenGrantKycTransactionBody?, Object>(
        key: 'tokenGrantKyc',
        parse: (v) => proto_token_grant_kyc.HederaTokenGrantKycTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenRevokeKyc: json.valueTo<proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody?, Object>(
        key: 'tokenRevokeKyc',
        parse: (v) => proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenDeletion: json.valueTo<proto_token_delete.HederaTokenDeleteTransactionBody?, Object>(
        key: 'tokenDeletion',
        parse: (v) => proto_token_delete.HederaTokenDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenUpdate: json.valueTo<proto_token_update.HederaTokenUpdateTransactionBody?, Object>(
        key: 'tokenUpdate',
        parse: (v) => proto_token_update.HederaTokenUpdateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenMint: json.valueTo<proto_token_mint.HederaTokenMintTransactionBody?, Object>(
        key: 'tokenMint',
        parse: (v) => proto_token_mint.HederaTokenMintTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenBurn: json.valueTo<proto_token_burn.HederaTokenBurnTransactionBody?, Object>(
        key: 'tokenBurn',
        parse: (v) => proto_token_burn.HederaTokenBurnTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenWipe: json.valueTo<proto_token_wipe_account.HederaTokenWipeAccountTransactionBody?, Object>(
        key: 'tokenWipe',
        parse: (v) => proto_token_wipe_account.HederaTokenWipeAccountTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenAssociate: json.valueTo<proto_token_associate.HederaTokenAssociateTransactionBody?, Object>(
        key: 'tokenAssociate',
        parse: (v) => proto_token_associate.HederaTokenAssociateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenDissociate: json.valueTo<proto_token_dissociate.HederaTokenDissociateTransactionBody?, Object>(
        key: 'tokenDissociate',
        parse: (v) => proto_token_dissociate.HederaTokenDissociateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      scheduleDelete: json.valueTo<proto_schedule_delete.HederaScheduleDeleteTransactionBody?, Object>(
        key: 'scheduleDelete',
        parse: (v) => proto_schedule_delete.HederaScheduleDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenPause: json.valueTo<proto_token_pause.HederaTokenPauseTransactionBody?, Object>(
        key: 'token_pause',
        parse: (v) => proto_token_pause.HederaTokenPauseTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenUnpause: json.valueTo<proto_token_unpause.HederaTokenUnpauseTransactionBody?, Object>(
        key: 'token_unpause',
        parse: (v) => proto_token_unpause.HederaTokenUnpauseTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      cryptoApproveAllowance: json.valueTo<proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody?, Object>(
        key: 'cryptoApproveAllowance',
        parse: (v) => proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      cryptoDeleteAllowance: json.valueTo<proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody?, Object>(
        key: 'cryptoDeleteAllowance',
        parse: (v) => proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenFeeScheduleUpdate: json.valueTo<proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody?, Object>(
        key: 'token_fee_schedule_update',
        parse: (v) => proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      utilPrng: json.valueTo<proto_util_prng.HederaUtilPrngTransactionBody?, Object>(
        key: 'util_prng',
        parse: (v) => proto_util_prng.HederaUtilPrngTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenUpdateNfts: json.valueTo<proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody?, Object>(
        key: 'token_update_nfts',
        parse: (v) => proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nodeCreate: json.valueTo<com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody?, Object>(
        key: 'nodeCreate',
        parse: (v) => com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nodeUpdate: json.valueTo<com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody?, Object>(
        key: 'nodeUpdate',
        parse: (v) => com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nodeDelete: json.valueTo<com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody?, Object>(
        key: 'nodeDelete',
        parse: (v) => com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenReject: json.valueTo<proto_token_reject.HederaTokenRejectTransactionBody?, Object>(
        key: 'tokenReject',
        parse: (v) => proto_token_reject.HederaTokenRejectTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenCancelAirdrop: json.valueTo<proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody?, Object>(
        key: 'tokenCancelAirdrop',
        parse: (v) => proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenClaimAirdrop: json.valueTo<proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody?, Object>(
        key: 'tokenClaimAirdrop',
        parse: (v) => proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenAirdrop: json.valueTo<proto_token_airdrop.HederaTokenAirdropTransactionBody?, Object>(
        key: 'tokenAirdrop',
        parse: (v) => proto_token_airdrop.HederaTokenAirdropTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      registeredNodeCreate: json.valueTo<com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody?, Object>(
        key: 'registeredNodeCreate',
        parse: (v) => com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      registeredNodeUpdate: json.valueTo<com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody?, Object>(
        key: 'registeredNodeUpdate',
        parse: (v) => com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      registeredNodeDelete: json.valueTo<com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody?, Object>(
        key: 'registeredNodeDelete',
        parse: (v) => com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      maxCustomFees: (json.valueEnsureAsList<dynamic>('max_custom_fees', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_custom_fees.HederaCustomFeeLimit, Object>(
          value: e,
          parse: (v) => proto_custom_fees.HederaCustomFeeLimit.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaSchedulableTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSchedulableTransactionBody(
      transactionFee: decode.getBigInt<BigInt?>(1),
      memo: decode.getString<String?>(2),
      contractCall: decode.messageTo<proto_contract_call.HederaContractCallTransactionBody?>(3, (b) => proto_contract_call.HederaContractCallTransactionBody.deserialize(b)),
      contractCreateInstance: decode.messageTo<proto_contract_create.HederaContractCreateTransactionBody?>(4, (b) => proto_contract_create.HederaContractCreateTransactionBody.deserialize(b)),
      contractUpdateInstance: decode.messageTo<proto_contract_update.HederaContractUpdateTransactionBody?>(5, (b) => proto_contract_update.HederaContractUpdateTransactionBody.deserialize(b)),
      contractDeleteInstance: decode.messageTo<proto_contract_delete.HederaContractDeleteTransactionBody?>(6, (b) => proto_contract_delete.HederaContractDeleteTransactionBody.deserialize(b)),
      cryptoCreateAccount: decode.messageTo<proto_crypto_create.HederaCryptoCreateTransactionBody?>(7, (b) => proto_crypto_create.HederaCryptoCreateTransactionBody.deserialize(b)),
      cryptoDelete: decode.messageTo<proto_crypto_delete.HederaCryptoDeleteTransactionBody?>(8, (b) => proto_crypto_delete.HederaCryptoDeleteTransactionBody.deserialize(b)),
      cryptoTransfer: decode.messageTo<proto_crypto_transfer.HederaCryptoTransferTransactionBody?>(9, (b) => proto_crypto_transfer.HederaCryptoTransferTransactionBody.deserialize(b)),
      cryptoUpdateAccount: decode.messageTo<proto_crypto_update.HederaCryptoUpdateTransactionBody?>(10, (b) => proto_crypto_update.HederaCryptoUpdateTransactionBody.deserialize(b)),
      fileAppend: decode.messageTo<proto_file_append.HederaFileAppendTransactionBody?>(11, (b) => proto_file_append.HederaFileAppendTransactionBody.deserialize(b)),
      fileCreate: decode.messageTo<proto_file_create.HederaFileCreateTransactionBody?>(12, (b) => proto_file_create.HederaFileCreateTransactionBody.deserialize(b)),
      fileDelete: decode.messageTo<proto_file_delete.HederaFileDeleteTransactionBody?>(13, (b) => proto_file_delete.HederaFileDeleteTransactionBody.deserialize(b)),
      fileUpdate: decode.messageTo<proto_file_update.HederaFileUpdateTransactionBody?>(14, (b) => proto_file_update.HederaFileUpdateTransactionBody.deserialize(b)),
      systemDelete: decode.messageTo<proto_system_delete.HederaSystemDeleteTransactionBody?>(15, (b) => proto_system_delete.HederaSystemDeleteTransactionBody.deserialize(b)),
      systemUndelete: decode.messageTo<proto_system_undelete.HederaSystemUndeleteTransactionBody?>(16, (b) => proto_system_undelete.HederaSystemUndeleteTransactionBody.deserialize(b)),
      freeze: decode.messageTo<proto_freeze.HederaFreezeTransactionBody?>(17, (b) => proto_freeze.HederaFreezeTransactionBody.deserialize(b)),
      consensusCreateTopic: decode.messageTo<proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody?>(18, (b) => proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody.deserialize(b)),
      consensusUpdateTopic: decode.messageTo<proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody?>(19, (b) => proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody.deserialize(b)),
      consensusDeleteTopic: decode.messageTo<proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody?>(20, (b) => proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody.deserialize(b)),
      consensusSubmitMessage: decode.messageTo<proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody?>(21, (b) => proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody.deserialize(b)),
      tokenCreation: decode.messageTo<proto_token_create.HederaTokenCreateTransactionBody?>(22, (b) => proto_token_create.HederaTokenCreateTransactionBody.deserialize(b)),
      tokenFreeze: decode.messageTo<proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody?>(23, (b) => proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody.deserialize(b)),
      tokenUnfreeze: decode.messageTo<proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody?>(24, (b) => proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody.deserialize(b)),
      tokenGrantKyc: decode.messageTo<proto_token_grant_kyc.HederaTokenGrantKycTransactionBody?>(25, (b) => proto_token_grant_kyc.HederaTokenGrantKycTransactionBody.deserialize(b)),
      tokenRevokeKyc: decode.messageTo<proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody?>(26, (b) => proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody.deserialize(b)),
      tokenDeletion: decode.messageTo<proto_token_delete.HederaTokenDeleteTransactionBody?>(27, (b) => proto_token_delete.HederaTokenDeleteTransactionBody.deserialize(b)),
      tokenUpdate: decode.messageTo<proto_token_update.HederaTokenUpdateTransactionBody?>(28, (b) => proto_token_update.HederaTokenUpdateTransactionBody.deserialize(b)),
      tokenMint: decode.messageTo<proto_token_mint.HederaTokenMintTransactionBody?>(29, (b) => proto_token_mint.HederaTokenMintTransactionBody.deserialize(b)),
      tokenBurn: decode.messageTo<proto_token_burn.HederaTokenBurnTransactionBody?>(30, (b) => proto_token_burn.HederaTokenBurnTransactionBody.deserialize(b)),
      tokenWipe: decode.messageTo<proto_token_wipe_account.HederaTokenWipeAccountTransactionBody?>(31, (b) => proto_token_wipe_account.HederaTokenWipeAccountTransactionBody.deserialize(b)),
      tokenAssociate: decode.messageTo<proto_token_associate.HederaTokenAssociateTransactionBody?>(32, (b) => proto_token_associate.HederaTokenAssociateTransactionBody.deserialize(b)),
      tokenDissociate: decode.messageTo<proto_token_dissociate.HederaTokenDissociateTransactionBody?>(33, (b) => proto_token_dissociate.HederaTokenDissociateTransactionBody.deserialize(b)),
      scheduleDelete: decode.messageTo<proto_schedule_delete.HederaScheduleDeleteTransactionBody?>(34, (b) => proto_schedule_delete.HederaScheduleDeleteTransactionBody.deserialize(b)),
      tokenPause: decode.messageTo<proto_token_pause.HederaTokenPauseTransactionBody?>(35, (b) => proto_token_pause.HederaTokenPauseTransactionBody.deserialize(b)),
      tokenUnpause: decode.messageTo<proto_token_unpause.HederaTokenUnpauseTransactionBody?>(36, (b) => proto_token_unpause.HederaTokenUnpauseTransactionBody.deserialize(b)),
      cryptoApproveAllowance: decode.messageTo<proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody?>(37, (b) => proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody.deserialize(b)),
      cryptoDeleteAllowance: decode.messageTo<proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody?>(38, (b) => proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody.deserialize(b)),
      tokenFeeScheduleUpdate: decode.messageTo<proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody?>(39, (b) => proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody.deserialize(b)),
      utilPrng: decode.messageTo<proto_util_prng.HederaUtilPrngTransactionBody?>(40, (b) => proto_util_prng.HederaUtilPrngTransactionBody.deserialize(b)),
      tokenUpdateNfts: decode.messageTo<proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody?>(41, (b) => proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody.deserialize(b)),
      nodeCreate: decode.messageTo<com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody?>(42, (b) => com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody.deserialize(b)),
      nodeUpdate: decode.messageTo<com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody?>(43, (b) => com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody.deserialize(b)),
      nodeDelete: decode.messageTo<com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody?>(44, (b) => com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody.deserialize(b)),
      tokenReject: decode.messageTo<proto_token_reject.HederaTokenRejectTransactionBody?>(45, (b) => proto_token_reject.HederaTokenRejectTransactionBody.deserialize(b)),
      tokenCancelAirdrop: decode.messageTo<proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody?>(46, (b) => proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody.deserialize(b)),
      tokenClaimAirdrop: decode.messageTo<proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody?>(47, (b) => proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody.deserialize(b)),
      tokenAirdrop: decode.messageTo<proto_token_airdrop.HederaTokenAirdropTransactionBody?>(48, (b) => proto_token_airdrop.HederaTokenAirdropTransactionBody.deserialize(b)),
      registeredNodeCreate: decode.messageTo<com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody?>(49, (b) => com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody.deserialize(b)),
      registeredNodeUpdate: decode.messageTo<com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody?>(50, (b) => com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody.deserialize(b)),
      registeredNodeDelete: decode.messageTo<com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody?>(51, (b) => com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody.deserialize(b)),
      maxCustomFees: decode.getListOfBytes(1001).map((b) => proto_custom_fees.HederaCustomFeeLimit.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSchedulableTransactionBody;

}



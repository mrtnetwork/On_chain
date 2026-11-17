import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_call.dart"
    as proto_contract_call;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_create.dart"
    as proto_contract_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_update.dart"
    as proto_contract_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_add_live_hash.dart"
    as proto_crypto_add_live_hash;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_create.dart"
    as proto_crypto_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_delete.dart"
    as proto_crypto_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_delete_live_hash.dart"
    as proto_crypto_delete_live_hash;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_transfer.dart"
    as proto_crypto_transfer;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_update.dart"
    as proto_crypto_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_append.dart"
    as proto_file_append;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_create.dart"
    as proto_file_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_delete.dart"
    as proto_file_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_update.dart"
    as proto_file_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/system_delete.dart"
    as proto_system_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/system_undelete.dart"
    as proto_system_undelete;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_delete.dart"
    as proto_contract_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/freeze.dart"
    as proto_freeze;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_create_topic.dart"
    as proto_consensus_create_topic;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_update_topic.dart"
    as proto_consensus_update_topic;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_delete_topic.dart"
    as proto_consensus_delete_topic;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_submit_message.dart"
    as proto_consensus_submit_message;
import "package:on_chain/hedera/src/proto_messages/proto/src/unchecked_submit.dart"
    as proto_unchecked_submit;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_create.dart"
    as proto_token_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_freeze_account.dart"
    as proto_token_freeze_account;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_unfreeze_account.dart"
    as proto_token_unfreeze_account;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_grant_kyc.dart"
    as proto_token_grant_kyc;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_revoke_kyc.dart"
    as proto_token_revoke_kyc;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_delete.dart"
    as proto_token_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_update.dart"
    as proto_token_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_mint.dart"
    as proto_token_mint;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_burn.dart"
    as proto_token_burn;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_wipe_account.dart"
    as proto_token_wipe_account;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_associate.dart"
    as proto_token_associate;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_dissociate.dart"
    as proto_token_dissociate;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedule_create.dart"
    as proto_schedule_create;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedule_delete.dart"
    as proto_schedule_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedule_sign.dart"
    as proto_schedule_sign;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_fee_schedule_update.dart"
    as proto_token_fee_schedule_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_pause.dart"
    as proto_token_pause;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_unpause.dart"
    as proto_token_unpause;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_approve_allowance.dart"
    as proto_crypto_approve_allowance;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_delete_allowance.dart"
    as proto_crypto_delete_allowance;
import "package:on_chain/hedera/src/proto_messages/proto/src/ethereum_transaction.dart"
    as proto_ethereum_transaction;
import "package:on_chain/hedera/src/proto_messages/proto/src/node_stake_update.dart"
    as proto_node_stake_update;
import "package:on_chain/hedera/src/proto_messages/proto/src/util_prng.dart"
    as proto_util_prng;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_update_nfts.dart"
    as proto_token_update_nfts;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/node_create.dart"
    as com_hedera_hapi_node_addressbook_node_create;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/node_update.dart"
    as com_hedera_hapi_node_addressbook_node_update;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/node_delete.dart"
    as com_hedera_hapi_node_addressbook_node_delete;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_reject.dart"
    as proto_token_reject;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_airdrop.dart"
    as proto_token_airdrop;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_cancel_airdrop.dart"
    as proto_token_cancel_airdrop;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_claim_airdrop.dart"
    as proto_token_claim_airdrop;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/state_signature_transaction.dart"
    as com_hedera_hapi_platform_event_state_signature_transaction;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/hints/src/hints_preprocessing_vote.dart"
    as com_hedera_hapi_services_auxiliary_hints_hints_preprocessing_vote;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/hints/src/hints_key_publication.dart"
    as com_hedera_hapi_services_auxiliary_hints_hints_key_publication;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/hints/src/hints_partial_signature.dart"
    as com_hedera_hapi_services_auxiliary_hints_hints_partial_signature;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/history/src/history_proof_signature.dart"
    as com_hedera_hapi_services_auxiliary_history_history_proof_signature;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/history/src/history_proof_key_publication.dart"
    as com_hedera_hapi_services_auxiliary_history_history_proof_key_publication;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/history/src/history_proof_vote.dart"
    as com_hedera_hapi_services_auxiliary_history_history_proof_vote;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/hints/src/crs_publication.dart"
    as com_hedera_hapi_services_auxiliary_hints_crs_publication;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/hooks/src/hook_store.dart"
    as com_hedera_hapi_node_hooks_hook_store;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/hooks/src/hook_dispatch.dart"
    as com_hedera_hapi_node_hooks_hook_dispatch;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/tss/src/ledger_id_publication.dart"
    as com_hedera_hapi_node_tss_ledger_id_publication;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_node_create.dart"
    as com_hedera_hapi_node_addressbook_registered_node_create;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_node_update.dart"
    as com_hedera_hapi_node_addressbook_registered_node_update;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_node_delete.dart"
    as com_hedera_hapi_node_addressbook_registered_node_delete;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/blockrecords/src/migration_root_hash_vote.dart"
    as com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_response.dart"
    as proto_transaction_response;

/// *
///  * # Transaction
///  * A (mostly legacy) wrapper around the bytes of a
///  * serialized `SignedTransaction` message.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// *
///  * A wrapper around signed transaction bytes.&lt;br/&gt;
///  * This was originally a transaction with body, signatures, and/or bytes,
///  * but is not only a wrapper around a byte array containing signed transction
///  * bytes.
///  *
///  * The `signedTransactionBytes` field is REQUIRED and MUST contain a valid,
///  * serialized, `SignedTransaction` message.&lt;br/&gt;
///  * All other fields are deprecated and MUST NOT be set.
///  *
///  * #### Additional Notes
///  * The four deprecated fields will be removed and reserved in a future release.
class HederaTransaction extends HederaProtoMessage with Equality {
  /// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.base"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
  /// *
  ///      * Replaced with `signedTransactionBytes`.&lt;br/&gt;
  ///      * The body of the transaction.
  final HederaTransactionBody? body;

  /// *
  ///      * Replaced with `signedTransactionBytes`.&lt;br/&gt;
  ///      * The signatures on the body.
  final proto_basic_types.HederaSignatureList? sigs;

  /// *
  ///      * Replaced with `signedTransactionBytes`.&lt;br/&gt;
  ///      * The signatures on the body with a newer format.
  final proto_basic_types.HederaSignatureMap? sigMap;

  /// *
  ///      * Replaced with `signedTransactionBytes`.&lt;br/&gt;
  ///      * TransactionBody serialized into bytes.
  final List<int>? bodyBytes;

  /// *
  ///      * A valid, serialized, `SignedTransaction` message.
  ///      * &lt;p&gt;
  ///      * This field MUST be present.
  ///      * This field MUST NOT exceed the current network transaction size limit
  ///      * (currently 6144 bytes).
  final List<int>? signedTransactionBytes;

  const HederaTransaction({
    this.body,
    this.sigs,
    this.sigMap,
    this.bodyBytes,
    this.signedTransactionBytes,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(
          1,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(
          2,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(
          3,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.bytes(
          4,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.bytes(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    body,
    sigs,
    sigMap,
    bodyBytes,
    signedTransactionBytes,
  ];

  HederaTransaction copyWith({
    HederaTransactionBody? body,

    proto_basic_types.HederaSignatureList? sigs,

    proto_basic_types.HederaSignatureMap? sigMap,

    List<int>? bodyBytes,

    List<int>? signedTransactionBytes,
  }) {
    return HederaTransaction(
      body: body ?? this.body,
      sigs: sigs ?? this.sigs,
      sigMap: sigMap ?? this.sigMap,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      signedTransactionBytes:
          signedTransactionBytes ?? this.signedTransactionBytes,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'body': config.encodeMessage(body),
      'sigs': config.encodeMessage(sigs),
      'sigMap': config.encodeMessage(sigMap),
      'bodyBytes': config.encodeBinary(bodyBytes),
      'signedTransactionBytes': config.encodeBinary(signedTransactionBytes),
    };
  }

  factory HederaTransaction.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransaction(
      body: json.valueTo<HederaTransactionBody?, Object>(
        key: 'body',
        parse:
            (v) => HederaTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sigs: json.valueTo<proto_basic_types.HederaSignatureList?, Object>(
        key: 'sigs',
        parse:
            (v) => proto_basic_types.HederaSignatureList.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sigMap: json.valueTo<proto_basic_types.HederaSignatureMap?, Object>(
        key: 'sigMap',
        parse:
            (v) => proto_basic_types.HederaSignatureMap.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bodyBytes: config.decodeBinary<List<int>?>(
        json.valueAs('bodyBytes', normalizeKeyLookup: config.normalizeKeys),
      ),
      signedTransactionBytes: config.decodeBinary<List<int>?>(
        json.valueAs(
          'signedTransactionBytes',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaTransaction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransaction(
      body: decode.messageTo<HederaTransactionBody?>(
        1,
        (b) => HederaTransactionBody.deserialize(b),
      ),
      sigs: decode.messageTo<proto_basic_types.HederaSignatureList?>(
        2,
        (b) => proto_basic_types.HederaSignatureList.deserialize(b),
      ),
      sigMap: decode.messageTo<proto_basic_types.HederaSignatureMap?>(
        3,
        (b) => proto_basic_types.HederaSignatureMap.deserialize(b),
      ),
      bodyBytes: decode.getBytes<List<int>?>(4),
      signedTransactionBytes: decode.getBytes<List<int>?>(5),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransaction;
}

/// *
///  * A transaction body.
///  *
///  * Every transaction is structured as a signed byte array. That byte array
///  * is a serialized `TransactionBody`.  The transaction body contains the full
///  * content of the transaction, while the `SignedTransaction` includes a
///  * signature map for signatures authenticating that byte array, and that is
///  * serialized and transmitted wrapped in a `Transaction` message.&lt;br/&gt;
///  * The bulk of this message is a `oneof` block which offers the option for
///  * any one of the transaction messages for the network.
///  * This message also includes several additional fields to specify
///  * various parameters required to process a transaction.
class HederaTransactionBody extends HederaProtoMessage with Equality {
  /// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
  /// *
  ///      * A transaction identifier.&lt;br/&gt;
  ///      * Each transaction is uniquely identified by its transaction
  ///      * identifier.
  ///      * &lt;p&gt;
  ///      * Each transaction identifier MUST be unique.&lt;br/&gt;
  ///      * Multiple transactions MAY be submitted with the same transaction
  ///      * identifier, but all except the first SHALL be rejected as duplicate
  ///      * transactions.&lt;br/&gt;
  ///      * This identifier MUST specify a `payer` account to be charged
  ///      * all fees associated with the transaction.&lt;br/&gt;
  ///      * This identifier MUST specify a "valid start time".&lt;br/&gt;
  ///      * The "valid start time" MUST be strictly _earlier_ than the current
  ///      * network consensus time.&lt;br/&gt;
  ///      * The "valid start time" MUST NOT be more than the current network
  ///      * configuration value for `transaction.maxValidDuration` seconds
  ///      * before the current network consensus time.&lt;br/&gt;
  ///      * This identifier MUST NOT set the `scheduled` flag.&lt;br/&gt;
  ///      * This identifier MUST NOT set a nonce value.
  final proto_basic_types.HederaTransactionID? transactionID;

  /// *
  ///      * A node account identifier.
  ///      * &lt;p&gt;
  ///      * This MUST identify the account of the consensus node to which
  ///      * this transaction is submitted.
  final proto_basic_types.HederaAccountID? nodeAccountID;

  /// *
  ///      * A maximum transaction fee, in tinybar.
  ///      * &lt;p&gt;
  ///      * The network SHALL NOT charge a transaction fee that exceeds this
  ///      * amount.&lt;br/&gt;
  ///      * The network MAY charge up to this amount, and reject the transaction,
  ///      * if the amount offered is insufficient to cover the required fees.&lt;br/&gt;
  ///      * The network MAY charge a minimum fee equal to 80% of the amount offered
  ///      * if the amount offered is much larger than the required fees.
  final BigInt? transactionFee;

  /// *
  ///      * A maximum duration in which to execute this transaction.
  ///      * &lt;p&gt;
  ///      * This transaction SHALL be rejected as expired if the valid start time,
  ///      * extended by this duration, is less than the current network consensus
  ///      * time when the transaction is submitted.&lt;br/&gt;
  ///      * This transaction SHALL be rejected with an invalid duration if this
  ///      * value is greater than the current network configuration value for
  ///      * `transaction.maxValidDuration`.
  final proto_duration.HederaDuration? transactionValidDuration;

  /// *
  ///      * Records are always generated.&lt;br/&gt;
  ///      * Obsolete option to not generate a record.
  ///      * &lt;p&gt;
  ///      * This flag SHALL be ignored. Every transaction SHALL generate a record,
  ///      * or block stream equivalent.
  final bool? generateRecord;

  /// *
  ///      * A short description for this transaction.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * The &lt;b&gt;public key&lt;/b&gt; of the trusted batch assembler.
  final proto_basic_types.HederaKey? batchKey;

  /// The fields here are ordered in strictly ascending field ordinal
  /// order due to limitations in PBJ.
  /// *
  ///          * Call a function defined on a smart contract.
  final proto_contract_call.HederaContractCallTransactionBody? contractCall;

  /// *
  ///          * Create a smart contract.
  final proto_contract_create.HederaContractCreateTransactionBody?
  contractCreateInstance;

  /// *
  ///          * Update a smart contract.
  final proto_contract_update.HederaContractUpdateTransactionBody?
  contractUpdateInstance;

  /// *
  ///          * An obsolete, and unsupported, operation to add a "live hash" to
  ///          * an account.
  final proto_crypto_add_live_hash.HederaCryptoAddLiveHashTransactionBody?
  cryptoAddLiveHash;

  /// *
  ///          * Create a new Hedera account.
  final proto_crypto_create.HederaCryptoCreateTransactionBody?
  cryptoCreateAccount;

  /// *
  ///          * Delete an Hedera account.&lt;br/&gt;
  ///          * This will mark the account as deleted, and transfer all remaining
  ///          * HBAR to a receiver account.
  final proto_crypto_delete.HederaCryptoDeleteTransactionBody? cryptoDelete;

  /// *
  ///          * An obsolete, and unsupported, operation to remove a "live hash" from
  ///          * an account.
  final proto_crypto_delete_live_hash.HederaCryptoDeleteLiveHashTransactionBody?
  cryptoDeleteLiveHash;

  /// *
  ///          * Transfer HBAR between accounts.
  final proto_crypto_transfer.HederaCryptoTransferTransactionBody?
  cryptoTransfer;

  /// *
  ///          * Modify an Hedera account.
  final proto_crypto_update.HederaCryptoUpdateTransactionBody?
  cryptoUpdateAccount;

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
  final proto_system_undelete.HederaSystemUndeleteTransactionBody?
  systemUndelete;

  /// *
  ///          * Delete a smart contract and transfer remaining balance
  ///          * to a specified account.
  final proto_contract_delete.HederaContractDeleteTransactionBody?
  contractDeleteInstance;

  /// *
  ///          * Freeze the network.&lt;br/&gt;
  ///          * This is actually several possible operations, and the caller
  ///          * should examine the "freeze service" for more detail.&lt;br/&gt;
  ///          * This is a privileged operation.
  final proto_freeze.HederaFreezeTransactionBody? freeze;

  /// *
  ///          * Create a topic.
  final proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody?
  consensusCreateTopic;

  /// *
  ///          * Update a topic.
  final proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody?
  consensusUpdateTopic;

  /// *
  ///          * Delete a topic.
  final proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody?
  consensusDeleteTopic;

  /// *
  ///          * Submit a message to a topic.&lt;br/&gt;
  ///          * A message may be "chunked", and submitted in parts, if the total
  ///          * message size exceeds the limit for a single transaction.
  final proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody?
  consensusSubmitMessage;

  /// *
  ///          * Unsupported system transaction.
  ///          * &lt;p&gt;
  ///          * This transaction MAY be implemented in testing networks, but
  ///          * SHALL NOT be enabled or supported in production environments.&lt;br/&gt;
  ///          * Clients MUST NOT call this method, and any such transaction SHALL
  ///          * be rejected.&lt;br/&gt;
  ///          * A network MAY choose to charge punitive fees for attempting to
  ///          * execute an `uncheckedSubmit`.
  final proto_unchecked_submit.HederaUncheckedSubmitBody? uncheckedSubmit;

  /// *
  ///          * Create a new Hedera token.
  final proto_token_create.HederaTokenCreateTransactionBody? tokenCreation;

  /// *
  ///          * Freeze an account with respect to a token.&lt;br/&gt;
  ///          * A frozen account cannot transact in that token until unfrozen.
  final proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody?
  tokenFreeze;

  /// *
  ///          * Unfreeze an account with respect to a token.
  final proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody?
  tokenUnfreeze;

  /// *
  ///          * Grant KYC to an account with respect to a token.&lt;br/&gt;
  ///          * KYC is generally a "know your customer" assertion that a
  ///          * responsible entity has sufficient information to positively
  ///          * identify the account holder to relevant authorities.
  final proto_token_grant_kyc.HederaTokenGrantKycTransactionBody? tokenGrantKyc;

  /// *
  ///          * Revoke KYC from an account with respect to a token.
  final proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody?
  tokenRevokeKyc;

  /// *
  ///          * Delete an Hedera token.&lt;br/&gt;
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
  final proto_token_wipe_account.HederaTokenWipeAccountTransactionBody?
  tokenWipe;

  /// *
  ///          * Associate tokens to an account.
  final proto_token_associate.HederaTokenAssociateTransactionBody?
  tokenAssociate;

  /// *
  ///          * Dissociate tokens from an account.
  final proto_token_dissociate.HederaTokenDissociateTransactionBody?
  tokenDissociate;

  /// *
  ///          * Create a schedule.&lt;br/&gt;
  ///          * A schedule is a request to execute a specific transaction, included
  ///          * in the create body, in the future. The scheduled transaction may
  ///          * execute as soon as all signature requirements are met with the
  ///          * schedule create or a subsequent schedule sign transaction.
  ///          * A schedule may, alternatively, execute on expiration if
  ///          * long-term schedules are enabled and the schedule meets signature
  ///          * requirements at that time.
  final proto_schedule_create.HederaScheduleCreateTransactionBody?
  scheduleCreate;

  /// *
  ///          * Delete a schedule.&lt;br/&gt;
  ///          * The schedule will be marked as deleted.
  final proto_schedule_delete.HederaScheduleDeleteTransactionBody?
  scheduleDelete;

  /// *
  ///          * Sign a schedule.&lt;br/&gt;
  ///          * Add one or more cryptographic keys to the list of keys that have
  ///          * signed a schedule, and which may serve to meet the signature
  ///          * requirements for the scheduled transaction.
  final proto_schedule_sign.HederaScheduleSignTransactionBody? scheduleSign;

  /// *
  ///          * Update the custom fee schedule for a token.&lt;br/&gt;
  ///          * This transaction must be signed by the "fee schedule key"
  ///          * for the token.
  final proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody?
  tokenFeeScheduleUpdate;

  /// *
  ///          * Pause a Token.
  ///          * &lt;p&gt;
  ///          * This transaction MUST be signed by the "pause key" for the token.
  final proto_token_pause.HederaTokenPauseTransactionBody? tokenPause;

  /// *
  ///          * Unpause a Token.
  ///          * &lt;p&gt;
  ///          * This transaction MUST be signed by the "pause key" for the token.
  final proto_token_unpause.HederaTokenUnpauseTransactionBody? tokenUnpause;

  /// *
  ///          * Add one or more approved allowances for spenders to transfer the
  ///          * paying account's hbar or tokens.
  final proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody?
  cryptoApproveAllowance;

  /// *
  ///          * Delete one or more approvals for spenders to transfer the
  ///          * paying account's hbar or tokens.
  final proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody?
  cryptoDeleteAllowance;

  /// *
  ///          * Perform an Ethereum encoded transaction.
  final proto_ethereum_transaction.HederaEthereumTransactionBody?
  ethereumTransaction;

  /// *
  ///          * Update the staking information.&lt;br/&gt;
  ///          * This internal transaction is performed at the end of a staking
  ///          * period to complete staking calculations and indicate that new
  ///          * staking period has started.
  final proto_node_stake_update.HederaNodeStakeUpdateTransactionBody?
  nodeStakeUpdate;

  /// *
  ///          * Provide a deterministic pseudorandom number based on network state.
  final proto_util_prng.HederaUtilPrngTransactionBody? utilPrng;

  /// *
  ///          * Update one or more non-fungible/unique tokens.&lt;br/&gt;
  ///          * This will update metadata for one or more serial numbers within
  ///          * a collection (token type).
  final proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody?
  tokenUpdateNfts;

  /// *
  ///          * Create a new node in the network address book.&lt;br/&gt;
  ///          * This is a privileged operation.
  ///          * &lt;p&gt;
  ///          * This transaction SHALL create a new consensus node record and add
  ///          * that record to the network address book.
  final com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody?
  nodeCreate;

  /// *
  ///          * Update a node in the network address book.&lt;br/&gt;
  ///          * This is a privileged operation.
  ///          * &lt;p&gt;
  ///          * This transaction SHALL update an existing consensus node record in
  ///          * the network address book.
  final com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody?
  nodeUpdate;

  /// *
  ///          * Delete a node from the network address book.&lt;br/&gt;
  ///          * This is a privileged operation.
  ///          * &lt;p&gt;
  ///          * This transaction SHALL mark an existing consensus node record as
  ///          * deleted and remove that node from the network address book.
  final com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody?
  nodeDelete;

  /// *
  ///          * Reject and return a token to treasury.&lt;br/&gt;
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
  ///          * "Airdrop" tokens.&lt;br/&gt;
  ///          * This transaction sends tokens from one or more "sender" accounts
  ///          * to one or more "recipient" accounts.
  ///          * &lt;p&gt;
  ///          * If a recipient account cannot immediately receive the token(s) sent,
  ///          * a "pending" airdrop SHALL be created and MUST be claimed.
  final proto_token_airdrop.HederaTokenAirdropTransactionBody? tokenAirdrop;

  /// *
  ///         * Cancel one or more "pending" airdrops that are not yet claimed.
  final proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody?
  tokenCancelAirdrop;

  /// *
  ///         * Claim one or more "pending" airdrops.
  final proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody?
  tokenClaimAirdrop;

  /// *
  ///          * A transaction body for signature of a state root hash gossiped to other nodes
  final com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?
  stateSignatureTransaction;

  /// *
  ///          * A transaction body for voting on hinTS aggregation keys.
  final com_hedera_hapi_services_auxiliary_hints_hints_preprocessing_vote.HederaHintsPreprocessingVoteTransactionBody?
  hintsPreprocessingVote;

  /// *
  ///          * A transaction body for publishing a node's hintTS key.
  final com_hedera_hapi_services_auxiliary_hints_hints_key_publication.HederaHintsKeyPublicationTransactionBody?
  hintsKeyPublication;

  /// *
  ///          * A transaction body for broadcasting a node's hintTS partial signature on a message.
  final com_hedera_hapi_services_auxiliary_hints_hints_partial_signature.HederaHintsPartialSignatureTransactionBody?
  hintsPartialSignature;

  /// *
  ///          * A transaction body for contributed a signature with a node's proof key to a history proof.
  final com_hedera_hapi_services_auxiliary_history_history_proof_signature.HederaHistoryProofSignatureTransactionBody?
  historyProofSignature;

  /// *
  ///          * A transaction body for publishing a node's metadata proof key.
  final com_hedera_hapi_services_auxiliary_history_history_proof_key_publication.HederaHistoryProofKeyPublicationTransactionBody?
  historyProofKeyPublication;

  /// *
  ///          * A transaction body for voting on a metadata proof descending from the ledger id.
  final com_hedera_hapi_services_auxiliary_history_history_proof_vote.HederaHistoryProofVoteTransactionBody?
  historyProofVote;

  /// *
  ///          * A transaction body for broadcasting a node's crs publication
  final com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?
  crsPublication;

  /// *
  ///          * A transaction body for handling a set of transactions atomically.
  final HederaAtomicBatchTransactionBody? atomicBatch;

  /// *
  ///          * A transaction body for updating the storage of an EVM hook.
  final com_hedera_hapi_node_hooks_hook_store.HederaHookStoreTransactionBody?
  hookStore;

  /// *
  ///          * An internal-only transaction body for dispatching a hook CRUD operation.
  final com_hedera_hapi_node_hooks_hook_dispatch.HederaHookDispatchTransactionBody?
  hookDispatch;

  /// *
  ///          * An internal-only transaction body for publishing the ledger id.
  final com_hedera_hapi_node_tss_ledger_id_publication.HederaLedgerIdPublicationTransactionBody?
  ledgerIdPublication;

  /// *
  ///          * Create a new registered node in the network address book.
  ///          * &lt;p&gt;
  ///          * This transaction SHALL create a new registered node record and add
  ///          * that record to the network state.
  final com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody?
  registeredNodeCreate;

  /// *
  ///          * Update a registered node in the network address book.
  ///          * &lt;p&gt;
  ///          * This transaction SHALL update an existing registered node record in
  ///          * the network state.
  final com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody?
  registeredNodeUpdate;

  /// *
  ///          * Delete a registered node from the network address book.
  ///          * &lt;p&gt;
  ///          * This transaction SHALL mark an existing registered node record as
  ///          * deleted.
  final com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody?
  registeredNodeDelete;

  /// *
  ///          * A transaction body for voting on migration wrapped record root hash state.
  final com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody?
  migrationRootHashVote;

  /// *
  ///      * A list of maximum custom fees that the users are willing to pay.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL.&lt;br/&gt;
  ///      * If left empty, the users are accepting to pay any custom fee.&lt;br/&gt;
  ///      * If used with a transaction type that does not support custom fee limits, the transaction will fail.
  final List<proto_custom_fees.HederaCustomFeeLimit> maxCustomFees;

  /// *
  ///      * If set to true, this transaction uses high-volume throttles and pricing
  ///      * for entity creation. It only affects supported transaction types; otherwise,
  ///      * it is ignored.
  final bool? highVolume;

  const HederaTransactionBody({
    this.transactionID,
    this.nodeAccountID,
    this.transactionFee,
    this.transactionValidDuration,
    this.generateRecord,
    this.memo,
    this.batchKey,
    this.contractCall,
    this.contractCreateInstance,
    this.contractUpdateInstance,
    this.cryptoAddLiveHash,
    this.cryptoCreateAccount,
    this.cryptoDelete,
    this.cryptoDeleteLiveHash,
    this.cryptoTransfer,
    this.cryptoUpdateAccount,
    this.fileAppend,
    this.fileCreate,
    this.fileDelete,
    this.fileUpdate,
    this.systemDelete,
    this.systemUndelete,
    this.contractDeleteInstance,
    this.freeze,
    this.consensusCreateTopic,
    this.consensusUpdateTopic,
    this.consensusDeleteTopic,
    this.consensusSubmitMessage,
    this.uncheckedSubmit,
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
    this.scheduleCreate,
    this.scheduleDelete,
    this.scheduleSign,
    this.tokenFeeScheduleUpdate,
    this.tokenPause,
    this.tokenUnpause,
    this.cryptoApproveAllowance,
    this.cryptoDeleteAllowance,
    this.ethereumTransaction,
    this.nodeStakeUpdate,
    this.utilPrng,
    this.tokenUpdateNfts,
    this.nodeCreate,
    this.nodeUpdate,
    this.nodeDelete,
    this.tokenReject,
    this.tokenAirdrop,
    this.tokenCancelAirdrop,
    this.tokenClaimAirdrop,
    this.stateSignatureTransaction,
    this.hintsPreprocessingVote,
    this.hintsKeyPublication,
    this.hintsPartialSignature,
    this.historyProofSignature,
    this.historyProofKeyPublication,
    this.historyProofVote,
    this.crsPublication,
    this.atomicBatch,
    this.hookStore,
    this.hookDispatch,
    this.ledgerIdPublication,
    this.registeredNodeCreate,
    this.registeredNodeUpdate,
    this.registeredNodeDelete,
    this.migrationRootHashVote,
    this.maxCustomFees = const [],
    this.highVolume,
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
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.bool(
          5,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.string(6),
        ProtoFieldConfig.message(73),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(
          10,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(
          13,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
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
        ProtoFieldConfig.message(52),
        ProtoFieldConfig.message(53),
        ProtoFieldConfig.message(54),
        ProtoFieldConfig.message(55),
        ProtoFieldConfig.message(56),
        ProtoFieldConfig.message(57),
        ProtoFieldConfig.message(58),
        ProtoFieldConfig.message(59),
        ProtoFieldConfig.message(60),
        ProtoFieldConfig.message(65),
        ProtoFieldConfig.message(66),
        ProtoFieldConfig.message(67),
        ProtoFieldConfig.message(68),
        ProtoFieldConfig.message(69),
        ProtoFieldConfig.message(70),
        ProtoFieldConfig.message(71),
        ProtoFieldConfig.message(72),
        ProtoFieldConfig.message(74),
        ProtoFieldConfig.message(75),
        ProtoFieldConfig.message(76),
        ProtoFieldConfig.message(77),
        ProtoFieldConfig.message(78),
        ProtoFieldConfig.message(79),
        ProtoFieldConfig.message(80),
        ProtoFieldConfig.message(81),
        ProtoFieldConfig.repeated(
          fieldNumber: 1001,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bool(1002),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transactionID,
    nodeAccountID,
    transactionFee,
    transactionValidDuration,
    generateRecord,
    memo,
    batchKey,
    contractCall,
    contractCreateInstance,
    contractUpdateInstance,
    cryptoAddLiveHash,
    cryptoCreateAccount,
    cryptoDelete,
    cryptoDeleteLiveHash,
    cryptoTransfer,
    cryptoUpdateAccount,
    fileAppend,
    fileCreate,
    fileDelete,
    fileUpdate,
    systemDelete,
    systemUndelete,
    contractDeleteInstance,
    freeze,
    consensusCreateTopic,
    consensusUpdateTopic,
    consensusDeleteTopic,
    consensusSubmitMessage,
    uncheckedSubmit,
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
    scheduleCreate,
    scheduleDelete,
    scheduleSign,
    tokenFeeScheduleUpdate,
    tokenPause,
    tokenUnpause,
    cryptoApproveAllowance,
    cryptoDeleteAllowance,
    ethereumTransaction,
    nodeStakeUpdate,
    utilPrng,
    tokenUpdateNfts,
    nodeCreate,
    nodeUpdate,
    nodeDelete,
    tokenReject,
    tokenAirdrop,
    tokenCancelAirdrop,
    tokenClaimAirdrop,
    stateSignatureTransaction,
    hintsPreprocessingVote,
    hintsKeyPublication,
    hintsPartialSignature,
    historyProofSignature,
    historyProofKeyPublication,
    historyProofVote,
    crsPublication,
    atomicBatch,
    hookStore,
    hookDispatch,
    ledgerIdPublication,
    registeredNodeCreate,
    registeredNodeUpdate,
    registeredNodeDelete,
    migrationRootHashVote,
    maxCustomFees,
    highVolume,
  ];

  HederaTransactionBody copyWith({
    proto_basic_types.HederaTransactionID? transactionID,

    proto_basic_types.HederaAccountID? nodeAccountID,

    BigInt? transactionFee,

    proto_duration.HederaDuration? transactionValidDuration,

    bool? generateRecord,

    String? memo,

    proto_basic_types.HederaKey? batchKey,

    proto_contract_call.HederaContractCallTransactionBody? contractCall,

    proto_contract_create.HederaContractCreateTransactionBody?
    contractCreateInstance,

    proto_contract_update.HederaContractUpdateTransactionBody?
    contractUpdateInstance,

    proto_crypto_add_live_hash.HederaCryptoAddLiveHashTransactionBody?
    cryptoAddLiveHash,

    proto_crypto_create.HederaCryptoCreateTransactionBody? cryptoCreateAccount,

    proto_crypto_delete.HederaCryptoDeleteTransactionBody? cryptoDelete,

    proto_crypto_delete_live_hash.HederaCryptoDeleteLiveHashTransactionBody?
    cryptoDeleteLiveHash,

    proto_crypto_transfer.HederaCryptoTransferTransactionBody? cryptoTransfer,

    proto_crypto_update.HederaCryptoUpdateTransactionBody? cryptoUpdateAccount,

    proto_file_append.HederaFileAppendTransactionBody? fileAppend,

    proto_file_create.HederaFileCreateTransactionBody? fileCreate,

    proto_file_delete.HederaFileDeleteTransactionBody? fileDelete,

    proto_file_update.HederaFileUpdateTransactionBody? fileUpdate,

    proto_system_delete.HederaSystemDeleteTransactionBody? systemDelete,

    proto_system_undelete.HederaSystemUndeleteTransactionBody? systemUndelete,

    proto_contract_delete.HederaContractDeleteTransactionBody?
    contractDeleteInstance,

    proto_freeze.HederaFreezeTransactionBody? freeze,

    proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody?
    consensusCreateTopic,

    proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody?
    consensusUpdateTopic,

    proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody?
    consensusDeleteTopic,

    proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody?
    consensusSubmitMessage,

    proto_unchecked_submit.HederaUncheckedSubmitBody? uncheckedSubmit,

    proto_token_create.HederaTokenCreateTransactionBody? tokenCreation,

    proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody?
    tokenFreeze,

    proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody?
    tokenUnfreeze,

    proto_token_grant_kyc.HederaTokenGrantKycTransactionBody? tokenGrantKyc,

    proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody? tokenRevokeKyc,

    proto_token_delete.HederaTokenDeleteTransactionBody? tokenDeletion,

    proto_token_update.HederaTokenUpdateTransactionBody? tokenUpdate,

    proto_token_mint.HederaTokenMintTransactionBody? tokenMint,

    proto_token_burn.HederaTokenBurnTransactionBody? tokenBurn,

    proto_token_wipe_account.HederaTokenWipeAccountTransactionBody? tokenWipe,

    proto_token_associate.HederaTokenAssociateTransactionBody? tokenAssociate,

    proto_token_dissociate.HederaTokenDissociateTransactionBody?
    tokenDissociate,

    proto_schedule_create.HederaScheduleCreateTransactionBody? scheduleCreate,

    proto_schedule_delete.HederaScheduleDeleteTransactionBody? scheduleDelete,

    proto_schedule_sign.HederaScheduleSignTransactionBody? scheduleSign,

    proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody?
    tokenFeeScheduleUpdate,

    proto_token_pause.HederaTokenPauseTransactionBody? tokenPause,

    proto_token_unpause.HederaTokenUnpauseTransactionBody? tokenUnpause,

    proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody?
    cryptoApproveAllowance,

    proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody?
    cryptoDeleteAllowance,

    proto_ethereum_transaction.HederaEthereumTransactionBody?
    ethereumTransaction,

    proto_node_stake_update.HederaNodeStakeUpdateTransactionBody?
    nodeStakeUpdate,

    proto_util_prng.HederaUtilPrngTransactionBody? utilPrng,

    proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody?
    tokenUpdateNfts,

    com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody?
    nodeCreate,

    com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody?
    nodeUpdate,

    com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody?
    nodeDelete,

    proto_token_reject.HederaTokenRejectTransactionBody? tokenReject,

    proto_token_airdrop.HederaTokenAirdropTransactionBody? tokenAirdrop,

    proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody?
    tokenCancelAirdrop,

    proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody?
    tokenClaimAirdrop,

    com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?
    stateSignatureTransaction,

    com_hedera_hapi_services_auxiliary_hints_hints_preprocessing_vote.HederaHintsPreprocessingVoteTransactionBody?
    hintsPreprocessingVote,

    com_hedera_hapi_services_auxiliary_hints_hints_key_publication.HederaHintsKeyPublicationTransactionBody?
    hintsKeyPublication,

    com_hedera_hapi_services_auxiliary_hints_hints_partial_signature.HederaHintsPartialSignatureTransactionBody?
    hintsPartialSignature,

    com_hedera_hapi_services_auxiliary_history_history_proof_signature.HederaHistoryProofSignatureTransactionBody?
    historyProofSignature,

    com_hedera_hapi_services_auxiliary_history_history_proof_key_publication.HederaHistoryProofKeyPublicationTransactionBody?
    historyProofKeyPublication,

    com_hedera_hapi_services_auxiliary_history_history_proof_vote.HederaHistoryProofVoteTransactionBody?
    historyProofVote,

    com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?
    crsPublication,

    HederaAtomicBatchTransactionBody? atomicBatch,

    com_hedera_hapi_node_hooks_hook_store.HederaHookStoreTransactionBody?
    hookStore,

    com_hedera_hapi_node_hooks_hook_dispatch.HederaHookDispatchTransactionBody?
    hookDispatch,

    com_hedera_hapi_node_tss_ledger_id_publication.HederaLedgerIdPublicationTransactionBody?
    ledgerIdPublication,

    com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody?
    registeredNodeCreate,

    com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody?
    registeredNodeUpdate,

    com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody?
    registeredNodeDelete,

    com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody?
    migrationRootHashVote,

    List<proto_custom_fees.HederaCustomFeeLimit>? maxCustomFees,

    bool? highVolume,
  }) {
    return HederaTransactionBody(
      transactionID: transactionID ?? this.transactionID,
      nodeAccountID: nodeAccountID ?? this.nodeAccountID,
      transactionFee: transactionFee ?? this.transactionFee,
      transactionValidDuration:
          transactionValidDuration ?? this.transactionValidDuration,
      generateRecord: generateRecord ?? this.generateRecord,
      memo: memo ?? this.memo,
      batchKey: batchKey ?? this.batchKey,
      contractCall: contractCall ?? this.contractCall,
      contractCreateInstance:
          contractCreateInstance ?? this.contractCreateInstance,
      contractUpdateInstance:
          contractUpdateInstance ?? this.contractUpdateInstance,
      cryptoAddLiveHash: cryptoAddLiveHash ?? this.cryptoAddLiveHash,
      cryptoCreateAccount: cryptoCreateAccount ?? this.cryptoCreateAccount,
      cryptoDelete: cryptoDelete ?? this.cryptoDelete,
      cryptoDeleteLiveHash: cryptoDeleteLiveHash ?? this.cryptoDeleteLiveHash,
      cryptoTransfer: cryptoTransfer ?? this.cryptoTransfer,
      cryptoUpdateAccount: cryptoUpdateAccount ?? this.cryptoUpdateAccount,
      fileAppend: fileAppend ?? this.fileAppend,
      fileCreate: fileCreate ?? this.fileCreate,
      fileDelete: fileDelete ?? this.fileDelete,
      fileUpdate: fileUpdate ?? this.fileUpdate,
      systemDelete: systemDelete ?? this.systemDelete,
      systemUndelete: systemUndelete ?? this.systemUndelete,
      contractDeleteInstance:
          contractDeleteInstance ?? this.contractDeleteInstance,
      freeze: freeze ?? this.freeze,
      consensusCreateTopic: consensusCreateTopic ?? this.consensusCreateTopic,
      consensusUpdateTopic: consensusUpdateTopic ?? this.consensusUpdateTopic,
      consensusDeleteTopic: consensusDeleteTopic ?? this.consensusDeleteTopic,
      consensusSubmitMessage:
          consensusSubmitMessage ?? this.consensusSubmitMessage,
      uncheckedSubmit: uncheckedSubmit ?? this.uncheckedSubmit,
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
      scheduleCreate: scheduleCreate ?? this.scheduleCreate,
      scheduleDelete: scheduleDelete ?? this.scheduleDelete,
      scheduleSign: scheduleSign ?? this.scheduleSign,
      tokenFeeScheduleUpdate:
          tokenFeeScheduleUpdate ?? this.tokenFeeScheduleUpdate,
      tokenPause: tokenPause ?? this.tokenPause,
      tokenUnpause: tokenUnpause ?? this.tokenUnpause,
      cryptoApproveAllowance:
          cryptoApproveAllowance ?? this.cryptoApproveAllowance,
      cryptoDeleteAllowance:
          cryptoDeleteAllowance ?? this.cryptoDeleteAllowance,
      ethereumTransaction: ethereumTransaction ?? this.ethereumTransaction,
      nodeStakeUpdate: nodeStakeUpdate ?? this.nodeStakeUpdate,
      utilPrng: utilPrng ?? this.utilPrng,
      tokenUpdateNfts: tokenUpdateNfts ?? this.tokenUpdateNfts,
      nodeCreate: nodeCreate ?? this.nodeCreate,
      nodeUpdate: nodeUpdate ?? this.nodeUpdate,
      nodeDelete: nodeDelete ?? this.nodeDelete,
      tokenReject: tokenReject ?? this.tokenReject,
      tokenAirdrop: tokenAirdrop ?? this.tokenAirdrop,
      tokenCancelAirdrop: tokenCancelAirdrop ?? this.tokenCancelAirdrop,
      tokenClaimAirdrop: tokenClaimAirdrop ?? this.tokenClaimAirdrop,
      stateSignatureTransaction:
          stateSignatureTransaction ?? this.stateSignatureTransaction,
      hintsPreprocessingVote:
          hintsPreprocessingVote ?? this.hintsPreprocessingVote,
      hintsKeyPublication: hintsKeyPublication ?? this.hintsKeyPublication,
      hintsPartialSignature:
          hintsPartialSignature ?? this.hintsPartialSignature,
      historyProofSignature:
          historyProofSignature ?? this.historyProofSignature,
      historyProofKeyPublication:
          historyProofKeyPublication ?? this.historyProofKeyPublication,
      historyProofVote: historyProofVote ?? this.historyProofVote,
      crsPublication: crsPublication ?? this.crsPublication,
      atomicBatch: atomicBatch ?? this.atomicBatch,
      hookStore: hookStore ?? this.hookStore,
      hookDispatch: hookDispatch ?? this.hookDispatch,
      ledgerIdPublication: ledgerIdPublication ?? this.ledgerIdPublication,
      registeredNodeCreate: registeredNodeCreate ?? this.registeredNodeCreate,
      registeredNodeUpdate: registeredNodeUpdate ?? this.registeredNodeUpdate,
      registeredNodeDelete: registeredNodeDelete ?? this.registeredNodeDelete,
      migrationRootHashVote:
          migrationRootHashVote ?? this.migrationRootHashVote,
      maxCustomFees: maxCustomFees ?? this.maxCustomFees,
      highVolume: highVolume ?? this.highVolume,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transactionID': config.encodeMessage(transactionID),
      'nodeAccountID': config.encodeMessage(nodeAccountID),
      'transactionFee': config.encodeBigint(transactionFee),
      'transactionValidDuration': config.encodeMessage(
        transactionValidDuration,
      ),
      'generateRecord': generateRecord,
      'memo': memo,
      'batch_key': config.encodeMessage(batchKey),
      'contractCall': config.encodeMessage(contractCall),
      'contractCreateInstance': config.encodeMessage(contractCreateInstance),
      'contractUpdateInstance': config.encodeMessage(contractUpdateInstance),
      'cryptoAddLiveHash': config.encodeMessage(cryptoAddLiveHash),
      'cryptoCreateAccount': config.encodeMessage(cryptoCreateAccount),
      'cryptoDelete': config.encodeMessage(cryptoDelete),
      'cryptoDeleteLiveHash': config.encodeMessage(cryptoDeleteLiveHash),
      'cryptoTransfer': config.encodeMessage(cryptoTransfer),
      'cryptoUpdateAccount': config.encodeMessage(cryptoUpdateAccount),
      'fileAppend': config.encodeMessage(fileAppend),
      'fileCreate': config.encodeMessage(fileCreate),
      'fileDelete': config.encodeMessage(fileDelete),
      'fileUpdate': config.encodeMessage(fileUpdate),
      'systemDelete': config.encodeMessage(systemDelete),
      'systemUndelete': config.encodeMessage(systemUndelete),
      'contractDeleteInstance': config.encodeMessage(contractDeleteInstance),
      'freeze': config.encodeMessage(freeze),
      'consensusCreateTopic': config.encodeMessage(consensusCreateTopic),
      'consensusUpdateTopic': config.encodeMessage(consensusUpdateTopic),
      'consensusDeleteTopic': config.encodeMessage(consensusDeleteTopic),
      'consensusSubmitMessage': config.encodeMessage(consensusSubmitMessage),
      'uncheckedSubmit': config.encodeMessage(uncheckedSubmit),
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
      'scheduleCreate': config.encodeMessage(scheduleCreate),
      'scheduleDelete': config.encodeMessage(scheduleDelete),
      'scheduleSign': config.encodeMessage(scheduleSign),
      'token_fee_schedule_update': config.encodeMessage(tokenFeeScheduleUpdate),
      'token_pause': config.encodeMessage(tokenPause),
      'token_unpause': config.encodeMessage(tokenUnpause),
      'cryptoApproveAllowance': config.encodeMessage(cryptoApproveAllowance),
      'cryptoDeleteAllowance': config.encodeMessage(cryptoDeleteAllowance),
      'ethereumTransaction': config.encodeMessage(ethereumTransaction),
      'node_stake_update': config.encodeMessage(nodeStakeUpdate),
      'util_prng': config.encodeMessage(utilPrng),
      'token_update_nfts': config.encodeMessage(tokenUpdateNfts),
      'nodeCreate': config.encodeMessage(nodeCreate),
      'nodeUpdate': config.encodeMessage(nodeUpdate),
      'nodeDelete': config.encodeMessage(nodeDelete),
      'tokenReject': config.encodeMessage(tokenReject),
      'tokenAirdrop': config.encodeMessage(tokenAirdrop),
      'tokenCancelAirdrop': config.encodeMessage(tokenCancelAirdrop),
      'tokenClaimAirdrop': config.encodeMessage(tokenClaimAirdrop),
      'state_signature_transaction': config.encodeMessage(
        stateSignatureTransaction,
      ),
      'hints_preprocessing_vote': config.encodeMessage(hintsPreprocessingVote),
      'hints_key_publication': config.encodeMessage(hintsKeyPublication),
      'hints_partial_signature': config.encodeMessage(hintsPartialSignature),
      'history_proof_signature': config.encodeMessage(historyProofSignature),
      'history_proof_key_publication': config.encodeMessage(
        historyProofKeyPublication,
      ),
      'history_proof_vote': config.encodeMessage(historyProofVote),
      'crs_publication': config.encodeMessage(crsPublication),
      'atomic_batch': config.encodeMessage(atomicBatch),
      'hook_store': config.encodeMessage(hookStore),
      'hook_dispatch': config.encodeMessage(hookDispatch),
      'ledger_id_publication': config.encodeMessage(ledgerIdPublication),
      'registeredNodeCreate': config.encodeMessage(registeredNodeCreate),
      'registeredNodeUpdate': config.encodeMessage(registeredNodeUpdate),
      'registeredNodeDelete': config.encodeMessage(registeredNodeDelete),
      'migration_root_hash_vote': config.encodeMessage(migrationRootHashVote),
      'max_custom_fees':
          maxCustomFees.map((e) => config.encodeMessage(e)).toList(),
      'high_volume': highVolume,
    };
  }

  factory HederaTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionBody(
      transactionID: json
          .valueTo<proto_basic_types.HederaTransactionID?, Object>(
            key: 'transactionID',
            parse:
                (v) => proto_basic_types.HederaTransactionID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      nodeAccountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'nodeAccountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionFee: json.valueAsBigInt<BigInt?>(
        'transactionFee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionValidDuration: json
          .valueTo<proto_duration.HederaDuration?, Object>(
            key: 'transactionValidDuration',
            parse:
                (v) => proto_duration.HederaDuration.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      generateRecord: json.valueAsBool<bool?>(
        'generateRecord',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      batchKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'batch_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCall: json.valueTo<
        proto_contract_call.HederaContractCallTransactionBody?,
        Object
      >(
        key: 'contractCall',
        parse:
            (v) =>
                proto_contract_call.HederaContractCallTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCreateInstance: json.valueTo<
        proto_contract_create.HederaContractCreateTransactionBody?,
        Object
      >(
        key: 'contractCreateInstance',
        parse:
            (v) => proto_contract_create
                .HederaContractCreateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractUpdateInstance: json.valueTo<
        proto_contract_update.HederaContractUpdateTransactionBody?,
        Object
      >(
        key: 'contractUpdateInstance',
        parse:
            (v) => proto_contract_update
                .HederaContractUpdateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoAddLiveHash: json.valueTo<
        proto_crypto_add_live_hash.HederaCryptoAddLiveHashTransactionBody?,
        Object
      >(
        key: 'cryptoAddLiveHash',
        parse:
            (v) => proto_crypto_add_live_hash
                .HederaCryptoAddLiveHashTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoCreateAccount: json.valueTo<
        proto_crypto_create.HederaCryptoCreateTransactionBody?,
        Object
      >(
        key: 'cryptoCreateAccount',
        parse:
            (v) =>
                proto_crypto_create.HederaCryptoCreateTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoDelete: json.valueTo<
        proto_crypto_delete.HederaCryptoDeleteTransactionBody?,
        Object
      >(
        key: 'cryptoDelete',
        parse:
            (v) =>
                proto_crypto_delete.HederaCryptoDeleteTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoDeleteLiveHash: json.valueTo<
        proto_crypto_delete_live_hash.HederaCryptoDeleteLiveHashTransactionBody?,
        Object
      >(
        key: 'cryptoDeleteLiveHash',
        parse:
            (v) => proto_crypto_delete_live_hash
                .HederaCryptoDeleteLiveHashTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoTransfer: json.valueTo<
        proto_crypto_transfer.HederaCryptoTransferTransactionBody?,
        Object
      >(
        key: 'cryptoTransfer',
        parse:
            (v) => proto_crypto_transfer
                .HederaCryptoTransferTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoUpdateAccount: json.valueTo<
        proto_crypto_update.HederaCryptoUpdateTransactionBody?,
        Object
      >(
        key: 'cryptoUpdateAccount',
        parse:
            (v) =>
                proto_crypto_update.HederaCryptoUpdateTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileAppend: json
          .valueTo<proto_file_append.HederaFileAppendTransactionBody?, Object>(
            key: 'fileAppend',
            parse:
                (v) =>
                    proto_file_append.HederaFileAppendTransactionBody.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      fileCreate: json
          .valueTo<proto_file_create.HederaFileCreateTransactionBody?, Object>(
            key: 'fileCreate',
            parse:
                (v) =>
                    proto_file_create.HederaFileCreateTransactionBody.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      fileDelete: json
          .valueTo<proto_file_delete.HederaFileDeleteTransactionBody?, Object>(
            key: 'fileDelete',
            parse:
                (v) =>
                    proto_file_delete.HederaFileDeleteTransactionBody.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      fileUpdate: json
          .valueTo<proto_file_update.HederaFileUpdateTransactionBody?, Object>(
            key: 'fileUpdate',
            parse:
                (v) =>
                    proto_file_update.HederaFileUpdateTransactionBody.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      systemDelete: json.valueTo<
        proto_system_delete.HederaSystemDeleteTransactionBody?,
        Object
      >(
        key: 'systemDelete',
        parse:
            (v) =>
                proto_system_delete.HederaSystemDeleteTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      systemUndelete: json.valueTo<
        proto_system_undelete.HederaSystemUndeleteTransactionBody?,
        Object
      >(
        key: 'systemUndelete',
        parse:
            (v) => proto_system_undelete
                .HederaSystemUndeleteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractDeleteInstance: json.valueTo<
        proto_contract_delete.HederaContractDeleteTransactionBody?,
        Object
      >(
        key: 'contractDeleteInstance',
        parse:
            (v) => proto_contract_delete
                .HederaContractDeleteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      freeze: json.valueTo<proto_freeze.HederaFreezeTransactionBody?, Object>(
        key: 'freeze',
        parse:
            (v) => proto_freeze.HederaFreezeTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusCreateTopic: json.valueTo<
        proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody?,
        Object
      >(
        key: 'consensusCreateTopic',
        parse:
            (v) => proto_consensus_create_topic
                .HederaConsensusCreateTopicTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusUpdateTopic: json.valueTo<
        proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody?,
        Object
      >(
        key: 'consensusUpdateTopic',
        parse:
            (v) => proto_consensus_update_topic
                .HederaConsensusUpdateTopicTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusDeleteTopic: json.valueTo<
        proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody?,
        Object
      >(
        key: 'consensusDeleteTopic',
        parse:
            (v) => proto_consensus_delete_topic
                .HederaConsensusDeleteTopicTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusSubmitMessage: json.valueTo<
        proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody?,
        Object
      >(
        key: 'consensusSubmitMessage',
        parse:
            (v) => proto_consensus_submit_message
                .HederaConsensusSubmitMessageTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      uncheckedSubmit: json
          .valueTo<proto_unchecked_submit.HederaUncheckedSubmitBody?, Object>(
            key: 'uncheckedSubmit',
            parse:
                (v) =>
                    proto_unchecked_submit.HederaUncheckedSubmitBody.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tokenCreation: json.valueTo<
        proto_token_create.HederaTokenCreateTransactionBody?,
        Object
      >(
        key: 'tokenCreation',
        parse:
            (v) => proto_token_create.HederaTokenCreateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenFreeze: json.valueTo<
        proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody?,
        Object
      >(
        key: 'tokenFreeze',
        parse:
            (v) => proto_token_freeze_account
                .HederaTokenFreezeAccountTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenUnfreeze: json.valueTo<
        proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody?,
        Object
      >(
        key: 'tokenUnfreeze',
        parse:
            (v) => proto_token_unfreeze_account
                .HederaTokenUnfreezeAccountTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGrantKyc: json.valueTo<
        proto_token_grant_kyc.HederaTokenGrantKycTransactionBody?,
        Object
      >(
        key: 'tokenGrantKyc',
        parse:
            (v) => proto_token_grant_kyc
                .HederaTokenGrantKycTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenRevokeKyc: json.valueTo<
        proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody?,
        Object
      >(
        key: 'tokenRevokeKyc',
        parse:
            (v) => proto_token_revoke_kyc
                .HederaTokenRevokeKycTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenDeletion: json.valueTo<
        proto_token_delete.HederaTokenDeleteTransactionBody?,
        Object
      >(
        key: 'tokenDeletion',
        parse:
            (v) => proto_token_delete.HederaTokenDeleteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenUpdate: json.valueTo<
        proto_token_update.HederaTokenUpdateTransactionBody?,
        Object
      >(
        key: 'tokenUpdate',
        parse:
            (v) => proto_token_update.HederaTokenUpdateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenMint: json
          .valueTo<proto_token_mint.HederaTokenMintTransactionBody?, Object>(
            key: 'tokenMint',
            parse:
                (v) => proto_token_mint.HederaTokenMintTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tokenBurn: json
          .valueTo<proto_token_burn.HederaTokenBurnTransactionBody?, Object>(
            key: 'tokenBurn',
            parse:
                (v) => proto_token_burn.HederaTokenBurnTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tokenWipe: json.valueTo<
        proto_token_wipe_account.HederaTokenWipeAccountTransactionBody?,
        Object
      >(
        key: 'tokenWipe',
        parse:
            (v) => proto_token_wipe_account
                .HederaTokenWipeAccountTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenAssociate: json.valueTo<
        proto_token_associate.HederaTokenAssociateTransactionBody?,
        Object
      >(
        key: 'tokenAssociate',
        parse:
            (v) => proto_token_associate
                .HederaTokenAssociateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenDissociate: json.valueTo<
        proto_token_dissociate.HederaTokenDissociateTransactionBody?,
        Object
      >(
        key: 'tokenDissociate',
        parse:
            (v) => proto_token_dissociate
                .HederaTokenDissociateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduleCreate: json.valueTo<
        proto_schedule_create.HederaScheduleCreateTransactionBody?,
        Object
      >(
        key: 'scheduleCreate',
        parse:
            (v) => proto_schedule_create
                .HederaScheduleCreateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduleDelete: json.valueTo<
        proto_schedule_delete.HederaScheduleDeleteTransactionBody?,
        Object
      >(
        key: 'scheduleDelete',
        parse:
            (v) => proto_schedule_delete
                .HederaScheduleDeleteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduleSign: json.valueTo<
        proto_schedule_sign.HederaScheduleSignTransactionBody?,
        Object
      >(
        key: 'scheduleSign',
        parse:
            (v) =>
                proto_schedule_sign.HederaScheduleSignTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenFeeScheduleUpdate: json.valueTo<
        proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody?,
        Object
      >(
        key: 'token_fee_schedule_update',
        parse:
            (v) => proto_token_fee_schedule_update
                .HederaTokenFeeScheduleUpdateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenPause: json
          .valueTo<proto_token_pause.HederaTokenPauseTransactionBody?, Object>(
            key: 'token_pause',
            parse:
                (v) =>
                    proto_token_pause.HederaTokenPauseTransactionBody.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tokenUnpause: json.valueTo<
        proto_token_unpause.HederaTokenUnpauseTransactionBody?,
        Object
      >(
        key: 'token_unpause',
        parse:
            (v) =>
                proto_token_unpause.HederaTokenUnpauseTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoApproveAllowance: json.valueTo<
        proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody?,
        Object
      >(
        key: 'cryptoApproveAllowance',
        parse:
            (v) => proto_crypto_approve_allowance
                .HederaCryptoApproveAllowanceTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoDeleteAllowance: json.valueTo<
        proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody?,
        Object
      >(
        key: 'cryptoDeleteAllowance',
        parse:
            (v) => proto_crypto_delete_allowance
                .HederaCryptoDeleteAllowanceTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ethereumTransaction: json.valueTo<
        proto_ethereum_transaction.HederaEthereumTransactionBody?,
        Object
      >(
        key: 'ethereumTransaction',
        parse:
            (v) => proto_ethereum_transaction
                .HederaEthereumTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeStakeUpdate: json.valueTo<
        proto_node_stake_update.HederaNodeStakeUpdateTransactionBody?,
        Object
      >(
        key: 'node_stake_update',
        parse:
            (v) => proto_node_stake_update
                .HederaNodeStakeUpdateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      utilPrng: json
          .valueTo<proto_util_prng.HederaUtilPrngTransactionBody?, Object>(
            key: 'util_prng',
            parse:
                (v) => proto_util_prng.HederaUtilPrngTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tokenUpdateNfts: json.valueTo<
        proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody?,
        Object
      >(
        key: 'token_update_nfts',
        parse:
            (v) => proto_token_update_nfts
                .HederaTokenUpdateNftsTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeCreate: json.valueTo<
        com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody?,
        Object
      >(
        key: 'nodeCreate',
        parse:
            (v) => com_hedera_hapi_node_addressbook_node_create
                .HederaNodeCreateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeUpdate: json.valueTo<
        com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody?,
        Object
      >(
        key: 'nodeUpdate',
        parse:
            (v) => com_hedera_hapi_node_addressbook_node_update
                .HederaNodeUpdateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeDelete: json.valueTo<
        com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody?,
        Object
      >(
        key: 'nodeDelete',
        parse:
            (v) => com_hedera_hapi_node_addressbook_node_delete
                .HederaNodeDeleteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenReject: json.valueTo<
        proto_token_reject.HederaTokenRejectTransactionBody?,
        Object
      >(
        key: 'tokenReject',
        parse:
            (v) => proto_token_reject.HederaTokenRejectTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenAirdrop: json.valueTo<
        proto_token_airdrop.HederaTokenAirdropTransactionBody?,
        Object
      >(
        key: 'tokenAirdrop',
        parse:
            (v) =>
                proto_token_airdrop.HederaTokenAirdropTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenCancelAirdrop: json.valueTo<
        proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody?,
        Object
      >(
        key: 'tokenCancelAirdrop',
        parse:
            (v) => proto_token_cancel_airdrop
                .HederaTokenCancelAirdropTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenClaimAirdrop: json.valueTo<
        proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody?,
        Object
      >(
        key: 'tokenClaimAirdrop',
        parse:
            (v) => proto_token_claim_airdrop
                .HederaTokenClaimAirdropTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stateSignatureTransaction: json.valueTo<
        com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?,
        Object
      >(
        key: 'state_signature_transaction',
        parse:
            (v) => com_hedera_hapi_platform_event_state_signature_transaction
                .HederaStateSignatureTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hintsPreprocessingVote: json.valueTo<
        com_hedera_hapi_services_auxiliary_hints_hints_preprocessing_vote.HederaHintsPreprocessingVoteTransactionBody?,
        Object
      >(
        key: 'hints_preprocessing_vote',
        parse:
            (v) =>
                com_hedera_hapi_services_auxiliary_hints_hints_preprocessing_vote
                    .HederaHintsPreprocessingVoteTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hintsKeyPublication: json.valueTo<
        com_hedera_hapi_services_auxiliary_hints_hints_key_publication.HederaHintsKeyPublicationTransactionBody?,
        Object
      >(
        key: 'hints_key_publication',
        parse:
            (v) =>
                com_hedera_hapi_services_auxiliary_hints_hints_key_publication
                    .HederaHintsKeyPublicationTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hintsPartialSignature: json.valueTo<
        com_hedera_hapi_services_auxiliary_hints_hints_partial_signature.HederaHintsPartialSignatureTransactionBody?,
        Object
      >(
        key: 'hints_partial_signature',
        parse:
            (v) =>
                com_hedera_hapi_services_auxiliary_hints_hints_partial_signature
                    .HederaHintsPartialSignatureTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historyProofSignature: json.valueTo<
        com_hedera_hapi_services_auxiliary_history_history_proof_signature.HederaHistoryProofSignatureTransactionBody?,
        Object
      >(
        key: 'history_proof_signature',
        parse:
            (v) =>
                com_hedera_hapi_services_auxiliary_history_history_proof_signature
                    .HederaHistoryProofSignatureTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historyProofKeyPublication: json.valueTo<
        com_hedera_hapi_services_auxiliary_history_history_proof_key_publication.HederaHistoryProofKeyPublicationTransactionBody?,
        Object
      >(
        key: 'history_proof_key_publication',
        parse:
            (v) =>
                com_hedera_hapi_services_auxiliary_history_history_proof_key_publication
                    .HederaHistoryProofKeyPublicationTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historyProofVote: json.valueTo<
        com_hedera_hapi_services_auxiliary_history_history_proof_vote.HederaHistoryProofVoteTransactionBody?,
        Object
      >(
        key: 'history_proof_vote',
        parse:
            (v) => com_hedera_hapi_services_auxiliary_history_history_proof_vote
                .HederaHistoryProofVoteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      crsPublication: json.valueTo<
        com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?,
        Object
      >(
        key: 'crs_publication',
        parse:
            (v) => com_hedera_hapi_services_auxiliary_hints_crs_publication
                .HederaCrsPublicationTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      atomicBatch: json.valueTo<HederaAtomicBatchTransactionBody?, Object>(
        key: 'atomic_batch',
        parse:
            (v) => HederaAtomicBatchTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hookStore: json.valueTo<
        com_hedera_hapi_node_hooks_hook_store.HederaHookStoreTransactionBody?,
        Object
      >(
        key: 'hook_store',
        parse:
            (v) => com_hedera_hapi_node_hooks_hook_store
                .HederaHookStoreTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hookDispatch: json.valueTo<
        com_hedera_hapi_node_hooks_hook_dispatch.HederaHookDispatchTransactionBody?,
        Object
      >(
        key: 'hook_dispatch',
        parse:
            (v) => com_hedera_hapi_node_hooks_hook_dispatch
                .HederaHookDispatchTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ledgerIdPublication: json.valueTo<
        com_hedera_hapi_node_tss_ledger_id_publication.HederaLedgerIdPublicationTransactionBody?,
        Object
      >(
        key: 'ledger_id_publication',
        parse:
            (v) => com_hedera_hapi_node_tss_ledger_id_publication
                .HederaLedgerIdPublicationTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      registeredNodeCreate: json.valueTo<
        com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody?,
        Object
      >(
        key: 'registeredNodeCreate',
        parse:
            (v) => com_hedera_hapi_node_addressbook_registered_node_create
                .HederaRegisteredNodeCreateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      registeredNodeUpdate: json.valueTo<
        com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody?,
        Object
      >(
        key: 'registeredNodeUpdate',
        parse:
            (v) => com_hedera_hapi_node_addressbook_registered_node_update
                .HederaRegisteredNodeUpdateTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      registeredNodeDelete: json.valueTo<
        com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody?,
        Object
      >(
        key: 'registeredNodeDelete',
        parse:
            (v) => com_hedera_hapi_node_addressbook_registered_node_delete
                .HederaRegisteredNodeDeleteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      migrationRootHashVote: json.valueTo<
        com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody?,
        Object
      >(
        key: 'migration_root_hash_vote',
        parse:
            (v) =>
                com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote
                    .HederaMigrationRootHashVoteTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxCustomFees:
          (json.valueEnsureAsList<dynamic>(
                'max_custom_fees',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_custom_fees.HederaCustomFeeLimit,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_custom_fees.HederaCustomFeeLimit.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      highVolume: json.valueAsBool<bool?>(
        'high_volume',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionBody(
      transactionID: decode.messageTo<proto_basic_types.HederaTransactionID?>(
        1,
        (b) => proto_basic_types.HederaTransactionID.deserialize(b),
      ),
      nodeAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      transactionFee: decode.getBigInt<BigInt?>(3),
      transactionValidDuration: decode
          .messageTo<proto_duration.HederaDuration?>(
            4,
            (b) => proto_duration.HederaDuration.deserialize(b),
          ),
      generateRecord: decode.getBool<bool?>(5),
      memo: decode.getString<String?>(6),
      batchKey: decode.messageTo<proto_basic_types.HederaKey?>(
        73,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      contractCall: decode
          .messageTo<proto_contract_call.HederaContractCallTransactionBody?>(
            7,
            (b) => proto_contract_call
                .HederaContractCallTransactionBody.deserialize(b),
          ),
      contractCreateInstance: decode.messageTo<
        proto_contract_create.HederaContractCreateTransactionBody?
      >(
        8,
        (b) => proto_contract_create
            .HederaContractCreateTransactionBody.deserialize(b),
      ),
      contractUpdateInstance: decode.messageTo<
        proto_contract_update.HederaContractUpdateTransactionBody?
      >(
        9,
        (b) => proto_contract_update
            .HederaContractUpdateTransactionBody.deserialize(b),
      ),
      cryptoAddLiveHash: decode.messageTo<
        proto_crypto_add_live_hash.HederaCryptoAddLiveHashTransactionBody?
      >(
        10,
        (b) => proto_crypto_add_live_hash
            .HederaCryptoAddLiveHashTransactionBody.deserialize(b),
      ),
      cryptoCreateAccount: decode
          .messageTo<proto_crypto_create.HederaCryptoCreateTransactionBody?>(
            11,
            (b) => proto_crypto_create
                .HederaCryptoCreateTransactionBody.deserialize(b),
          ),
      cryptoDelete: decode
          .messageTo<proto_crypto_delete.HederaCryptoDeleteTransactionBody?>(
            12,
            (b) => proto_crypto_delete
                .HederaCryptoDeleteTransactionBody.deserialize(b),
          ),
      cryptoDeleteLiveHash: decode.messageTo<
        proto_crypto_delete_live_hash.HederaCryptoDeleteLiveHashTransactionBody?
      >(
        13,
        (b) => proto_crypto_delete_live_hash
            .HederaCryptoDeleteLiveHashTransactionBody.deserialize(b),
      ),
      cryptoTransfer: decode.messageTo<
        proto_crypto_transfer.HederaCryptoTransferTransactionBody?
      >(
        14,
        (b) => proto_crypto_transfer
            .HederaCryptoTransferTransactionBody.deserialize(b),
      ),
      cryptoUpdateAccount: decode
          .messageTo<proto_crypto_update.HederaCryptoUpdateTransactionBody?>(
            15,
            (b) => proto_crypto_update
                .HederaCryptoUpdateTransactionBody.deserialize(b),
          ),
      fileAppend: decode.messageTo<
        proto_file_append.HederaFileAppendTransactionBody?
      >(
        16,
        (b) => proto_file_append.HederaFileAppendTransactionBody.deserialize(b),
      ),
      fileCreate: decode.messageTo<
        proto_file_create.HederaFileCreateTransactionBody?
      >(
        17,
        (b) => proto_file_create.HederaFileCreateTransactionBody.deserialize(b),
      ),
      fileDelete: decode.messageTo<
        proto_file_delete.HederaFileDeleteTransactionBody?
      >(
        18,
        (b) => proto_file_delete.HederaFileDeleteTransactionBody.deserialize(b),
      ),
      fileUpdate: decode.messageTo<
        proto_file_update.HederaFileUpdateTransactionBody?
      >(
        19,
        (b) => proto_file_update.HederaFileUpdateTransactionBody.deserialize(b),
      ),
      systemDelete: decode
          .messageTo<proto_system_delete.HederaSystemDeleteTransactionBody?>(
            20,
            (b) => proto_system_delete
                .HederaSystemDeleteTransactionBody.deserialize(b),
          ),
      systemUndelete: decode.messageTo<
        proto_system_undelete.HederaSystemUndeleteTransactionBody?
      >(
        21,
        (b) => proto_system_undelete
            .HederaSystemUndeleteTransactionBody.deserialize(b),
      ),
      contractDeleteInstance: decode.messageTo<
        proto_contract_delete.HederaContractDeleteTransactionBody?
      >(
        22,
        (b) => proto_contract_delete
            .HederaContractDeleteTransactionBody.deserialize(b),
      ),
      freeze: decode.messageTo<proto_freeze.HederaFreezeTransactionBody?>(
        23,
        (b) => proto_freeze.HederaFreezeTransactionBody.deserialize(b),
      ),
      consensusCreateTopic: decode.messageTo<
        proto_consensus_create_topic.HederaConsensusCreateTopicTransactionBody?
      >(
        24,
        (b) => proto_consensus_create_topic
            .HederaConsensusCreateTopicTransactionBody.deserialize(b),
      ),
      consensusUpdateTopic: decode.messageTo<
        proto_consensus_update_topic.HederaConsensusUpdateTopicTransactionBody?
      >(
        25,
        (b) => proto_consensus_update_topic
            .HederaConsensusUpdateTopicTransactionBody.deserialize(b),
      ),
      consensusDeleteTopic: decode.messageTo<
        proto_consensus_delete_topic.HederaConsensusDeleteTopicTransactionBody?
      >(
        26,
        (b) => proto_consensus_delete_topic
            .HederaConsensusDeleteTopicTransactionBody.deserialize(b),
      ),
      consensusSubmitMessage: decode.messageTo<
        proto_consensus_submit_message.HederaConsensusSubmitMessageTransactionBody?
      >(
        27,
        (b) => proto_consensus_submit_message
            .HederaConsensusSubmitMessageTransactionBody.deserialize(b),
      ),
      uncheckedSubmit: decode
          .messageTo<proto_unchecked_submit.HederaUncheckedSubmitBody?>(
            28,
            (b) =>
                proto_unchecked_submit.HederaUncheckedSubmitBody.deserialize(b),
          ),
      tokenCreation: decode
          .messageTo<proto_token_create.HederaTokenCreateTransactionBody?>(
            29,
            (b) => proto_token_create
                .HederaTokenCreateTransactionBody.deserialize(b),
          ),
      tokenFreeze: decode.messageTo<
        proto_token_freeze_account.HederaTokenFreezeAccountTransactionBody?
      >(
        31,
        (b) => proto_token_freeze_account
            .HederaTokenFreezeAccountTransactionBody.deserialize(b),
      ),
      tokenUnfreeze: decode.messageTo<
        proto_token_unfreeze_account.HederaTokenUnfreezeAccountTransactionBody?
      >(
        32,
        (b) => proto_token_unfreeze_account
            .HederaTokenUnfreezeAccountTransactionBody.deserialize(b),
      ),
      tokenGrantKyc: decode
          .messageTo<proto_token_grant_kyc.HederaTokenGrantKycTransactionBody?>(
            33,
            (b) => proto_token_grant_kyc
                .HederaTokenGrantKycTransactionBody.deserialize(b),
          ),
      tokenRevokeKyc: decode.messageTo<
        proto_token_revoke_kyc.HederaTokenRevokeKycTransactionBody?
      >(
        34,
        (b) => proto_token_revoke_kyc
            .HederaTokenRevokeKycTransactionBody.deserialize(b),
      ),
      tokenDeletion: decode
          .messageTo<proto_token_delete.HederaTokenDeleteTransactionBody?>(
            35,
            (b) => proto_token_delete
                .HederaTokenDeleteTransactionBody.deserialize(b),
          ),
      tokenUpdate: decode
          .messageTo<proto_token_update.HederaTokenUpdateTransactionBody?>(
            36,
            (b) => proto_token_update
                .HederaTokenUpdateTransactionBody.deserialize(b),
          ),
      tokenMint: decode
          .messageTo<proto_token_mint.HederaTokenMintTransactionBody?>(
            37,
            (b) =>
                proto_token_mint.HederaTokenMintTransactionBody.deserialize(b),
          ),
      tokenBurn: decode
          .messageTo<proto_token_burn.HederaTokenBurnTransactionBody?>(
            38,
            (b) =>
                proto_token_burn.HederaTokenBurnTransactionBody.deserialize(b),
          ),
      tokenWipe: decode.messageTo<
        proto_token_wipe_account.HederaTokenWipeAccountTransactionBody?
      >(
        39,
        (b) => proto_token_wipe_account
            .HederaTokenWipeAccountTransactionBody.deserialize(b),
      ),
      tokenAssociate: decode.messageTo<
        proto_token_associate.HederaTokenAssociateTransactionBody?
      >(
        40,
        (b) => proto_token_associate
            .HederaTokenAssociateTransactionBody.deserialize(b),
      ),
      tokenDissociate: decode.messageTo<
        proto_token_dissociate.HederaTokenDissociateTransactionBody?
      >(
        41,
        (b) => proto_token_dissociate
            .HederaTokenDissociateTransactionBody.deserialize(b),
      ),
      scheduleCreate: decode.messageTo<
        proto_schedule_create.HederaScheduleCreateTransactionBody?
      >(
        42,
        (b) => proto_schedule_create
            .HederaScheduleCreateTransactionBody.deserialize(b),
      ),
      scheduleDelete: decode.messageTo<
        proto_schedule_delete.HederaScheduleDeleteTransactionBody?
      >(
        43,
        (b) => proto_schedule_delete
            .HederaScheduleDeleteTransactionBody.deserialize(b),
      ),
      scheduleSign: decode
          .messageTo<proto_schedule_sign.HederaScheduleSignTransactionBody?>(
            44,
            (b) => proto_schedule_sign
                .HederaScheduleSignTransactionBody.deserialize(b),
          ),
      tokenFeeScheduleUpdate: decode.messageTo<
        proto_token_fee_schedule_update.HederaTokenFeeScheduleUpdateTransactionBody?
      >(
        45,
        (b) => proto_token_fee_schedule_update
            .HederaTokenFeeScheduleUpdateTransactionBody.deserialize(b),
      ),
      tokenPause: decode.messageTo<
        proto_token_pause.HederaTokenPauseTransactionBody?
      >(
        46,
        (b) => proto_token_pause.HederaTokenPauseTransactionBody.deserialize(b),
      ),
      tokenUnpause: decode
          .messageTo<proto_token_unpause.HederaTokenUnpauseTransactionBody?>(
            47,
            (b) => proto_token_unpause
                .HederaTokenUnpauseTransactionBody.deserialize(b),
          ),
      cryptoApproveAllowance: decode.messageTo<
        proto_crypto_approve_allowance.HederaCryptoApproveAllowanceTransactionBody?
      >(
        48,
        (b) => proto_crypto_approve_allowance
            .HederaCryptoApproveAllowanceTransactionBody.deserialize(b),
      ),
      cryptoDeleteAllowance: decode.messageTo<
        proto_crypto_delete_allowance.HederaCryptoDeleteAllowanceTransactionBody?
      >(
        49,
        (b) => proto_crypto_delete_allowance
            .HederaCryptoDeleteAllowanceTransactionBody.deserialize(b),
      ),
      ethereumTransaction: decode
          .messageTo<proto_ethereum_transaction.HederaEthereumTransactionBody?>(
            50,
            (b) => proto_ethereum_transaction
                .HederaEthereumTransactionBody.deserialize(b),
          ),
      nodeStakeUpdate: decode.messageTo<
        proto_node_stake_update.HederaNodeStakeUpdateTransactionBody?
      >(
        51,
        (b) => proto_node_stake_update
            .HederaNodeStakeUpdateTransactionBody.deserialize(b),
      ),
      utilPrng: decode
          .messageTo<proto_util_prng.HederaUtilPrngTransactionBody?>(
            52,
            (b) => proto_util_prng.HederaUtilPrngTransactionBody.deserialize(b),
          ),
      tokenUpdateNfts: decode.messageTo<
        proto_token_update_nfts.HederaTokenUpdateNftsTransactionBody?
      >(
        53,
        (b) => proto_token_update_nfts
            .HederaTokenUpdateNftsTransactionBody.deserialize(b),
      ),
      nodeCreate: decode.messageTo<
        com_hedera_hapi_node_addressbook_node_create.HederaNodeCreateTransactionBody?
      >(
        54,
        (b) => com_hedera_hapi_node_addressbook_node_create
            .HederaNodeCreateTransactionBody.deserialize(b),
      ),
      nodeUpdate: decode.messageTo<
        com_hedera_hapi_node_addressbook_node_update.HederaNodeUpdateTransactionBody?
      >(
        55,
        (b) => com_hedera_hapi_node_addressbook_node_update
            .HederaNodeUpdateTransactionBody.deserialize(b),
      ),
      nodeDelete: decode.messageTo<
        com_hedera_hapi_node_addressbook_node_delete.HederaNodeDeleteTransactionBody?
      >(
        56,
        (b) => com_hedera_hapi_node_addressbook_node_delete
            .HederaNodeDeleteTransactionBody.deserialize(b),
      ),
      tokenReject: decode
          .messageTo<proto_token_reject.HederaTokenRejectTransactionBody?>(
            57,
            (b) => proto_token_reject
                .HederaTokenRejectTransactionBody.deserialize(b),
          ),
      tokenAirdrop: decode
          .messageTo<proto_token_airdrop.HederaTokenAirdropTransactionBody?>(
            58,
            (b) => proto_token_airdrop
                .HederaTokenAirdropTransactionBody.deserialize(b),
          ),
      tokenCancelAirdrop: decode.messageTo<
        proto_token_cancel_airdrop.HederaTokenCancelAirdropTransactionBody?
      >(
        59,
        (b) => proto_token_cancel_airdrop
            .HederaTokenCancelAirdropTransactionBody.deserialize(b),
      ),
      tokenClaimAirdrop: decode.messageTo<
        proto_token_claim_airdrop.HederaTokenClaimAirdropTransactionBody?
      >(
        60,
        (b) => proto_token_claim_airdrop
            .HederaTokenClaimAirdropTransactionBody.deserialize(b),
      ),
      stateSignatureTransaction: decode.messageTo<
        com_hedera_hapi_platform_event_state_signature_transaction.HederaStateSignatureTransaction?
      >(
        65,
        (b) => com_hedera_hapi_platform_event_state_signature_transaction
            .HederaStateSignatureTransaction.deserialize(b),
      ),
      hintsPreprocessingVote: decode.messageTo<
        com_hedera_hapi_services_auxiliary_hints_hints_preprocessing_vote.HederaHintsPreprocessingVoteTransactionBody?
      >(
        66,
        (b) => com_hedera_hapi_services_auxiliary_hints_hints_preprocessing_vote
            .HederaHintsPreprocessingVoteTransactionBody.deserialize(b),
      ),
      hintsKeyPublication: decode.messageTo<
        com_hedera_hapi_services_auxiliary_hints_hints_key_publication.HederaHintsKeyPublicationTransactionBody?
      >(
        67,
        (b) => com_hedera_hapi_services_auxiliary_hints_hints_key_publication
            .HederaHintsKeyPublicationTransactionBody.deserialize(b),
      ),
      hintsPartialSignature: decode.messageTo<
        com_hedera_hapi_services_auxiliary_hints_hints_partial_signature.HederaHintsPartialSignatureTransactionBody?
      >(
        68,
        (b) => com_hedera_hapi_services_auxiliary_hints_hints_partial_signature
            .HederaHintsPartialSignatureTransactionBody.deserialize(b),
      ),
      historyProofSignature: decode.messageTo<
        com_hedera_hapi_services_auxiliary_history_history_proof_signature.HederaHistoryProofSignatureTransactionBody?
      >(
        69,
        (b) =>
            com_hedera_hapi_services_auxiliary_history_history_proof_signature
                .HederaHistoryProofSignatureTransactionBody.deserialize(b),
      ),
      historyProofKeyPublication: decode.messageTo<
        com_hedera_hapi_services_auxiliary_history_history_proof_key_publication.HederaHistoryProofKeyPublicationTransactionBody?
      >(
        70,
        (b) =>
            com_hedera_hapi_services_auxiliary_history_history_proof_key_publication
                .HederaHistoryProofKeyPublicationTransactionBody.deserialize(b),
      ),
      historyProofVote: decode.messageTo<
        com_hedera_hapi_services_auxiliary_history_history_proof_vote.HederaHistoryProofVoteTransactionBody?
      >(
        71,
        (b) => com_hedera_hapi_services_auxiliary_history_history_proof_vote
            .HederaHistoryProofVoteTransactionBody.deserialize(b),
      ),
      crsPublication: decode.messageTo<
        com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?
      >(
        72,
        (b) => com_hedera_hapi_services_auxiliary_hints_crs_publication
            .HederaCrsPublicationTransactionBody.deserialize(b),
      ),
      atomicBatch: decode.messageTo<HederaAtomicBatchTransactionBody?>(
        74,
        (b) => HederaAtomicBatchTransactionBody.deserialize(b),
      ),
      hookStore: decode.messageTo<
        com_hedera_hapi_node_hooks_hook_store.HederaHookStoreTransactionBody?
      >(
        75,
        (b) => com_hedera_hapi_node_hooks_hook_store
            .HederaHookStoreTransactionBody.deserialize(b),
      ),
      hookDispatch: decode.messageTo<
        com_hedera_hapi_node_hooks_hook_dispatch.HederaHookDispatchTransactionBody?
      >(
        76,
        (b) => com_hedera_hapi_node_hooks_hook_dispatch
            .HederaHookDispatchTransactionBody.deserialize(b),
      ),
      ledgerIdPublication: decode.messageTo<
        com_hedera_hapi_node_tss_ledger_id_publication.HederaLedgerIdPublicationTransactionBody?
      >(
        77,
        (b) => com_hedera_hapi_node_tss_ledger_id_publication
            .HederaLedgerIdPublicationTransactionBody.deserialize(b),
      ),
      registeredNodeCreate: decode.messageTo<
        com_hedera_hapi_node_addressbook_registered_node_create.HederaRegisteredNodeCreateTransactionBody?
      >(
        78,
        (b) => com_hedera_hapi_node_addressbook_registered_node_create
            .HederaRegisteredNodeCreateTransactionBody.deserialize(b),
      ),
      registeredNodeUpdate: decode.messageTo<
        com_hedera_hapi_node_addressbook_registered_node_update.HederaRegisteredNodeUpdateTransactionBody?
      >(
        79,
        (b) => com_hedera_hapi_node_addressbook_registered_node_update
            .HederaRegisteredNodeUpdateTransactionBody.deserialize(b),
      ),
      registeredNodeDelete: decode.messageTo<
        com_hedera_hapi_node_addressbook_registered_node_delete.HederaRegisteredNodeDeleteTransactionBody?
      >(
        80,
        (b) => com_hedera_hapi_node_addressbook_registered_node_delete
            .HederaRegisteredNodeDeleteTransactionBody.deserialize(b),
      ),
      migrationRootHashVote: decode.messageTo<
        com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody?
      >(
        81,
        (b) =>
            com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote
                .HederaMigrationRootHashVoteTransactionBody.deserialize(b),
      ),
      maxCustomFees:
          decode
              .getListOfBytes(1001)
              .map((b) => proto_custom_fees.HederaCustomFeeLimit.deserialize(b))
              .toList(),
      highVolume: decode.getBool<bool?>(1002),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionBody;
}

/// *
///  * A transaction body for handling a set of transactions atomically.
class HederaAtomicBatchTransactionBody extends HederaProtoMessage
    with Equality {
  /// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.util"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
  /// *
  ///      * A list of signed bytes that represent the batch transactions.
  final List<List<int>> transactions;

  const HederaAtomicBatchTransactionBody({this.transactions = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.bytes,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transactions];

  HederaAtomicBatchTransactionBody copyWith({List<List<int>>? transactions}) {
    return HederaAtomicBatchTransactionBody(
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transactions': transactions.map((e) => config.encodeBinary(e)).toList(),
    };
  }

  factory HederaAtomicBatchTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaAtomicBatchTransactionBody(
      transactions:
          (json.valueEnsureAsList<dynamic>(
            'transactions',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
    );
  }

  factory HederaAtomicBatchTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAtomicBatchTransactionBody(
      transactions: decode.getListOfBytes(1),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoAtomicBatchTransactionBody;
}

class HederaServiceFileServiceCreateFile extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Create a file in HFS.
  final HederaTransaction? createFile;

  const HederaServiceFileServiceCreateFile({this.createFile});

  HederaServiceFileServiceCreateFile copyWith({HederaTransaction? createFile}) {
    return HederaServiceFileServiceCreateFile(
      createFile: createFile ?? this.createFile,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      createFile?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createFile?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'createFile': config.encodeMessage(createFile)};
  }

  factory HederaServiceFileServiceCreateFile.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceCreateFile(
      createFile: json.valueTo<HederaTransaction?, Object>(
        key: 'createFile',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceCreateFile;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceFileServiceUpdateFile extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Update a file in HFS.
  final HederaTransaction? updateFile;

  const HederaServiceFileServiceUpdateFile({this.updateFile});

  HederaServiceFileServiceUpdateFile copyWith({HederaTransaction? updateFile}) {
    return HederaServiceFileServiceUpdateFile(
      updateFile: updateFile ?? this.updateFile,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      updateFile?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateFile?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'updateFile': config.encodeMessage(updateFile)};
  }

  factory HederaServiceFileServiceUpdateFile.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceUpdateFile(
      updateFile: json.valueTo<HederaTransaction?, Object>(
        key: 'updateFile',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceUpdateFile;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceFileServiceDeleteFile extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete a file in HFS.&lt;br/&gt;
  ///      * The content of a file deleted in this manner is completely removed
  ///      * from network state, but the file metadata remains.
  final HederaTransaction? deleteFile;

  const HederaServiceFileServiceDeleteFile({this.deleteFile});

  HederaServiceFileServiceDeleteFile copyWith({HederaTransaction? deleteFile}) {
    return HederaServiceFileServiceDeleteFile(
      deleteFile: deleteFile ?? this.deleteFile,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      deleteFile?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deleteFile?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'deleteFile': config.encodeMessage(deleteFile)};
  }

  factory HederaServiceFileServiceDeleteFile.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceDeleteFile(
      deleteFile: json.valueTo<HederaTransaction?, Object>(
        key: 'deleteFile',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceDeleteFile;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceFileServiceAppendContent extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Append content to a file in HFS.
  final HederaTransaction? appendContent;

  const HederaServiceFileServiceAppendContent({this.appendContent});

  HederaServiceFileServiceAppendContent copyWith({
    HederaTransaction? appendContent,
  }) {
    return HederaServiceFileServiceAppendContent(
      appendContent: appendContent ?? this.appendContent,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      appendContent?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => appendContent?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'appendContent': config.encodeMessage(appendContent)};
  }

  factory HederaServiceFileServiceAppendContent.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceAppendContent(
      appendContent: json.valueTo<HederaTransaction?, Object>(
        key: 'appendContent',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceAppendContent;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceFileServiceSystemDelete extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete a "regular" file without "owner" authorization.&lt;br/&gt;
  ///      * This transaction _does not_ require signatures for the keys in
  ///      * the file `keys` list, but must be signed by a "privileged" account.
  ///      * &lt;p&gt;
  ///      * This transaction SHALL NOT accept a file identifier for
  ///      * a "system" file.&lt;br/&gt;
  ///      * This transaction SHALL NOT remove the _content_ of the file from state.
  ///      * This permits use of the `systemUndelete` to reverse this action if
  ///      * performed in error.
  ///      * &lt;p&gt;
  ///      * This is a privileged transaction, and only accounts 2-59 are permitted
  ///      * to call this function, by default. The actual restriction is in the
  ///      * `api-permission.properties` file in the consensus node configuration.
  final HederaTransaction? systemDelete;

  const HederaServiceFileServiceSystemDelete({this.systemDelete});

  HederaServiceFileServiceSystemDelete copyWith({
    HederaTransaction? systemDelete,
  }) {
    return HederaServiceFileServiceSystemDelete(
      systemDelete: systemDelete ?? this.systemDelete,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      systemDelete?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => systemDelete?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'systemDelete': config.encodeMessage(systemDelete)};
  }

  factory HederaServiceFileServiceSystemDelete.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceSystemDelete(
      systemDelete: json.valueTo<HederaTransaction?, Object>(
        key: 'systemDelete',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceSystemDelete;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceFileServiceSystemUndelete extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Undelete a "regular" file.
  ///      * This transaction must be signed by a "privileged" account.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * This transaction SHALL NOT accept a file identifier for
  ///      * a "system" file.&lt;br/&gt;
  ///      * The file identified SHOULD have been previously deleted.&lt;br/&gt;
  ///      * This transaction SHALL NOT recover the _content_ of a file unless that
  ///      * file was deleted with a `systemDelete` transaction. The _content_ of a
  ///      * file deleted with a `fileDelete` transaction is not retained in state.
  ///      * &lt;p&gt;
  ///      * This is a privileged transaction, and only accounts 2-60 are permitted
  ///      * to call this function, by default. The actual restriction is in the
  ///      * `api-permission.properties` file in the consensus node configuration.
  final HederaTransaction? systemUndelete;

  const HederaServiceFileServiceSystemUndelete({this.systemUndelete});

  HederaServiceFileServiceSystemUndelete copyWith({
    HederaTransaction? systemUndelete,
  }) {
    return HederaServiceFileServiceSystemUndelete(
      systemUndelete: systemUndelete ?? this.systemUndelete,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      systemUndelete?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => systemUndelete?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'systemUndelete': config.encodeMessage(systemUndelete)};
  }

  factory HederaServiceFileServiceSystemUndelete.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceSystemUndelete(
      systemUndelete: json.valueTo<HederaTransaction?, Object>(
        key: 'systemUndelete',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceSystemUndelete;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceConsensusServiceCreateTopic extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Create an HCS topic.
  ///      * &lt;p&gt;
  ///      * On success, the resulting TransactionReceipt SHALL contain the newly
  ///      * created TopicId.&lt;br/&gt;
  ///      * If the `adminKey` is set on the topic, this transaction MUST be signed
  ///      * by that key.&lt;br/&gt;
  ///      * If the `adminKey` is _not_ set on the topic, this transaction MUST NOT
  ///      * set an `autoRenewAccount`. The new topic will be immutable and must be
  ///      * renewed manually.&lt;br/&gt;
  ///      * If the `autoRenewAccount` is set on the topic, this transaction MUST be
  ///      * signed by that account.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * The request body MUST be a
  ///      * [ConsensusCreateTopicTransactionBody](#proto.ConsensusCreateTopicTransactionBody)
  final HederaTransaction? createTopic;

  const HederaServiceConsensusServiceCreateTopic({this.createTopic});

  HederaServiceConsensusServiceCreateTopic copyWith({
    HederaTransaction? createTopic,
  }) {
    return HederaServiceConsensusServiceCreateTopic(
      createTopic: createTopic ?? this.createTopic,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      createTopic?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createTopic?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'createTopic': config.encodeMessage(createTopic)};
  }

  factory HederaServiceConsensusServiceCreateTopic.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceConsensusServiceCreateTopic(
      createTopic: json.valueTo<HederaTransaction?, Object>(
        key: 'createTopic',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceConsensusServiceCreateTopic;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceConsensusServiceUpdateTopic extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Update an HCS topic.
  ///      * &lt;p&gt;
  ///      * If the `adminKey` is not set on the topic, this transaction MUST extend
  ///      * the `expirationTime` and MUST NOT modify any other field.&lt;br/&gt;
  ///      * If the `adminKey` is set on the topic, this transaction MUST be signed
  ///      * by that key.&lt;br/&gt;
  ///      * If this transaction sets a new `adminKey`, this transaction MUST be
  ///      * signed by &lt;strong&gt;_both_&lt;/strong&gt; keys, the pre-update `adminKey` and
  ///      * the post-update `adminKey`.&lt;br/&gt;
  ///      * If this transaction sets a new, non-null, `autoRenewAccount`, the newly
  ///      * set account MUST sign this transaction.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * The request body MUST be a
  ///      * [ConsensusUpdateTopicTransactionBody](#proto.ConsensusUpdateTopicTransactionBody)
  final HederaTransaction? updateTopic;

  const HederaServiceConsensusServiceUpdateTopic({this.updateTopic});

  HederaServiceConsensusServiceUpdateTopic copyWith({
    HederaTransaction? updateTopic,
  }) {
    return HederaServiceConsensusServiceUpdateTopic(
      updateTopic: updateTopic ?? this.updateTopic,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      updateTopic?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateTopic?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'updateTopic': config.encodeMessage(updateTopic)};
  }

  factory HederaServiceConsensusServiceUpdateTopic.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceConsensusServiceUpdateTopic(
      updateTopic: json.valueTo<HederaTransaction?, Object>(
        key: 'updateTopic',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceConsensusServiceUpdateTopic;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceConsensusServiceDeleteTopic extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete an HCS topic.
  ///      * &lt;p&gt;
  ///      * If this transaction succeeds, all subsequent transactions referencing
  ///      * the deleted topic SHALL fail.&lt;br/&gt;
  ///      * The `adminKey` MUST be set on the topic and this transaction MUST be
  ///      * signed by that key.&lt;br/&gt;
  ///      * If the `adminKey` is not set on the topic, this transaction SHALL fail
  ///      * with a response code of `UNAUTHORIZED`. A topic without an `adminKey`
  ///      * cannot be deleted, but MAY expire.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * The request body MUST be a
  ///      * [ConsensusDeleteTopicTransactionBody](#proto.ConsensusDeleteTopicTransactionBody)
  final HederaTransaction? deleteTopic;

  const HederaServiceConsensusServiceDeleteTopic({this.deleteTopic});

  HederaServiceConsensusServiceDeleteTopic copyWith({
    HederaTransaction? deleteTopic,
  }) {
    return HederaServiceConsensusServiceDeleteTopic(
      deleteTopic: deleteTopic ?? this.deleteTopic,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      deleteTopic?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deleteTopic?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'deleteTopic': config.encodeMessage(deleteTopic)};
  }

  factory HederaServiceConsensusServiceDeleteTopic.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceConsensusServiceDeleteTopic(
      deleteTopic: json.valueTo<HederaTransaction?, Object>(
        key: 'deleteTopic',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceConsensusServiceDeleteTopic;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceConsensusServiceSubmitMessage extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Submit a message to an HCS topic.
  ///      * &lt;p&gt;
  ///      * Valid and authorized messages on valid topics will be ordered by the
  ///      * consensus service, published in the block stream, and available to all
  ///      * subscribers on this topic via the mirror nodes.&lt;br/&gt;
  ///      * If this transaction succeeds the resulting TransactionReceipt SHALL
  ///      * contain the latest topicSequenceNumber and topicRunningHash for the
  ///      * topic.&lt;br/&gt;
  ///      * If the topic has a `submitKey` then that key MUST sign this
  ///      * transaction.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * The request body MUST be a
  ///      * [ConsensusSubmitMessageTransactionBody](#proto.ConsensusSubmitMessageTransactionBody)
  final HederaTransaction? submitMessage;

  const HederaServiceConsensusServiceSubmitMessage({this.submitMessage});

  HederaServiceConsensusServiceSubmitMessage copyWith({
    HederaTransaction? submitMessage,
  }) {
    return HederaServiceConsensusServiceSubmitMessage(
      submitMessage: submitMessage ?? this.submitMessage,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      submitMessage?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => submitMessage?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'submitMessage': config.encodeMessage(submitMessage)};
  }

  factory HederaServiceConsensusServiceSubmitMessage.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceConsensusServiceSubmitMessage(
      submitMessage: json.valueTo<HederaTransaction?, Object>(
        key: 'submitMessage',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceConsensusServiceSubmitMessage;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceNetworkServiceUncheckedSubmit extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Submit a transaction that wraps another transaction which will
  ///      * skip most validation.
  ///      * &lt;p&gt;
  ///      * &lt;blockquote&gt;Important&lt;blockquote&gt;
  ///      * This query is obsolete, not supported, and SHALL fail with a pre-check
  ///      * result of `NOT_SUPPORTED`.
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  final HederaTransaction? uncheckedSubmit;

  const HederaServiceNetworkServiceUncheckedSubmit({this.uncheckedSubmit});

  HederaServiceNetworkServiceUncheckedSubmit copyWith({
    HederaTransaction? uncheckedSubmit,
  }) {
    return HederaServiceNetworkServiceUncheckedSubmit(
      uncheckedSubmit: uncheckedSubmit ?? this.uncheckedSubmit,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      uncheckedSubmit?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => uncheckedSubmit?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'uncheckedSubmit': config.encodeMessage(uncheckedSubmit)};
  }

  factory HederaServiceNetworkServiceUncheckedSubmit.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceNetworkServiceUncheckedSubmit(
      uncheckedSubmit: json.valueTo<HederaTransaction?, Object>(
        key: 'uncheckedSubmit',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceNetworkServiceUncheckedSubmit;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceCreateToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// The following queries are permanently removed
  /// getAccountNftInfos, getTokenNftInfos
  /// *
  ///      * Create a new token.
  final HederaTransaction? createToken;

  const HederaServiceTokenServiceCreateToken({this.createToken});

  HederaServiceTokenServiceCreateToken copyWith({
    HederaTransaction? createToken,
  }) {
    return HederaServiceTokenServiceCreateToken(
      createToken: createToken ?? this.createToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      createToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'createToken': config.encodeMessage(createToken)};
  }

  factory HederaServiceTokenServiceCreateToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceCreateToken(
      createToken: json.valueTo<HederaTransaction?, Object>(
        key: 'createToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceCreateToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceUpdateToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Update a token.
  final HederaTransaction? updateToken;

  const HederaServiceTokenServiceUpdateToken({this.updateToken});

  HederaServiceTokenServiceUpdateToken copyWith({
    HederaTransaction? updateToken,
  }) {
    return HederaServiceTokenServiceUpdateToken(
      updateToken: updateToken ?? this.updateToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      updateToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'updateToken': config.encodeMessage(updateToken)};
  }

  factory HederaServiceTokenServiceUpdateToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceUpdateToken(
      updateToken: json.valueTo<HederaTransaction?, Object>(
        key: 'updateToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceUpdateToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceMintToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Mint one or more tokens to the treasury account.
  ///      * &lt;p&gt;
  ///      * This MAY specify a quantity of fungible/common tokens or
  ///      * a list of specific non-fungible/unique tokes, but
  ///      * MUST NOT specify both.
  final HederaTransaction? mintToken;

  const HederaServiceTokenServiceMintToken({this.mintToken});

  HederaServiceTokenServiceMintToken copyWith({HederaTransaction? mintToken}) {
    return HederaServiceTokenServiceMintToken(
      mintToken: mintToken ?? this.mintToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      mintToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => mintToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'mintToken': config.encodeMessage(mintToken)};
  }

  factory HederaServiceTokenServiceMintToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceMintToken(
      mintToken: json.valueTo<HederaTransaction?, Object>(
        key: 'mintToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceMintToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceBurnToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Burn one or more tokens from the treasury account.
  ///      * &lt;p&gt;
  ///      * This MAY specify a quantity of fungible/common tokens or
  ///      * a list of specific non-fungible/unique tokes, but
  ///      * MUST NOT specify both.
  final HederaTransaction? burnToken;

  const HederaServiceTokenServiceBurnToken({this.burnToken});

  HederaServiceTokenServiceBurnToken copyWith({HederaTransaction? burnToken}) {
    return HederaServiceTokenServiceBurnToken(
      burnToken: burnToken ?? this.burnToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      burnToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => burnToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'burnToken': config.encodeMessage(burnToken)};
  }

  factory HederaServiceTokenServiceBurnToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceBurnToken(
      burnToken: json.valueTo<HederaTransaction?, Object>(
        key: 'burnToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceBurnToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceDeleteToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete a token.
  final HederaTransaction? deleteToken;

  const HederaServiceTokenServiceDeleteToken({this.deleteToken});

  HederaServiceTokenServiceDeleteToken copyWith({
    HederaTransaction? deleteToken,
  }) {
    return HederaServiceTokenServiceDeleteToken(
      deleteToken: deleteToken ?? this.deleteToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      deleteToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deleteToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'deleteToken': config.encodeMessage(deleteToken)};
  }

  factory HederaServiceTokenServiceDeleteToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceDeleteToken(
      deleteToken: json.valueTo<HederaTransaction?, Object>(
        key: 'deleteToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceDeleteToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceWipeTokenAccount extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Wipe one or more tokens from an identified Account.
  ///      * &lt;p&gt;
  ///      * This MAY specify a quantity of fungible/common tokens or
  ///      * a list of specific non-fungible/unique tokes, but
  ///      * MUST NOT specify both.
  final HederaTransaction? wipeTokenAccount;

  const HederaServiceTokenServiceWipeTokenAccount({this.wipeTokenAccount});

  HederaServiceTokenServiceWipeTokenAccount copyWith({
    HederaTransaction? wipeTokenAccount,
  }) {
    return HederaServiceTokenServiceWipeTokenAccount(
      wipeTokenAccount: wipeTokenAccount ?? this.wipeTokenAccount,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      wipeTokenAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => wipeTokenAccount?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'wipeTokenAccount': config.encodeMessage(wipeTokenAccount)};
  }

  factory HederaServiceTokenServiceWipeTokenAccount.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceWipeTokenAccount(
      wipeTokenAccount: json.valueTo<HederaTransaction?, Object>(
        key: 'wipeTokenAccount',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceWipeTokenAccount;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceFreezeTokenAccount extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Freeze the transfer of tokens to or from an identified Account.
  final HederaTransaction? freezeTokenAccount;

  const HederaServiceTokenServiceFreezeTokenAccount({this.freezeTokenAccount});

  HederaServiceTokenServiceFreezeTokenAccount copyWith({
    HederaTransaction? freezeTokenAccount,
  }) {
    return HederaServiceTokenServiceFreezeTokenAccount(
      freezeTokenAccount: freezeTokenAccount ?? this.freezeTokenAccount,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      freezeTokenAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => freezeTokenAccount?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'freezeTokenAccount': config.encodeMessage(freezeTokenAccount)};
  }

  factory HederaServiceTokenServiceFreezeTokenAccount.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceFreezeTokenAccount(
      freezeTokenAccount: json.valueTo<HederaTransaction?, Object>(
        key: 'freezeTokenAccount',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceFreezeTokenAccount;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceUnfreezeTokenAccount extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Unfreeze the transfer of tokens to or from an identified Account.
  final HederaTransaction? unfreezeTokenAccount;

  const HederaServiceTokenServiceUnfreezeTokenAccount({
    this.unfreezeTokenAccount,
  });

  HederaServiceTokenServiceUnfreezeTokenAccount copyWith({
    HederaTransaction? unfreezeTokenAccount,
  }) {
    return HederaServiceTokenServiceUnfreezeTokenAccount(
      unfreezeTokenAccount: unfreezeTokenAccount ?? this.unfreezeTokenAccount,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      unfreezeTokenAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unfreezeTokenAccount?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'unfreezeTokenAccount': config.encodeMessage(unfreezeTokenAccount)};
  }

  factory HederaServiceTokenServiceUnfreezeTokenAccount.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceUnfreezeTokenAccount(
      unfreezeTokenAccount: json.valueTo<HederaTransaction?, Object>(
        key: 'unfreezeTokenAccount',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceUnfreezeTokenAccount;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceGrantKycToTokenAccount extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Assert that KYC requirements are met for a specific account with
  ///      * respect to a specific token.
  final HederaTransaction? grantKycToTokenAccount;

  const HederaServiceTokenServiceGrantKycToTokenAccount({
    this.grantKycToTokenAccount,
  });

  HederaServiceTokenServiceGrantKycToTokenAccount copyWith({
    HederaTransaction? grantKycToTokenAccount,
  }) {
    return HederaServiceTokenServiceGrantKycToTokenAccount(
      grantKycToTokenAccount:
          grantKycToTokenAccount ?? this.grantKycToTokenAccount,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      grantKycToTokenAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => grantKycToTokenAccount?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'grantKycToTokenAccount': config.encodeMessage(grantKycToTokenAccount),
    };
  }

  factory HederaServiceTokenServiceGrantKycToTokenAccount.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceGrantKycToTokenAccount(
      grantKycToTokenAccount: json.valueTo<HederaTransaction?, Object>(
        key: 'grantKycToTokenAccount',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceGrantKycToTokenAccount;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceRevokeKycFromTokenAccount
    extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Assert that KYC requirements are _not_ met for a specific account with
  ///      * respect to a specific token.
  final HederaTransaction? revokeKycFromTokenAccount;

  const HederaServiceTokenServiceRevokeKycFromTokenAccount({
    this.revokeKycFromTokenAccount,
  });

  HederaServiceTokenServiceRevokeKycFromTokenAccount copyWith({
    HederaTransaction? revokeKycFromTokenAccount,
  }) {
    return HederaServiceTokenServiceRevokeKycFromTokenAccount(
      revokeKycFromTokenAccount:
          revokeKycFromTokenAccount ?? this.revokeKycFromTokenAccount,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      revokeKycFromTokenAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => revokeKycFromTokenAccount?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'revokeKycFromTokenAccount': config.encodeMessage(
        revokeKycFromTokenAccount,
      ),
    };
  }

  factory HederaServiceTokenServiceRevokeKycFromTokenAccount.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceRevokeKycFromTokenAccount(
      revokeKycFromTokenAccount: json.valueTo<HederaTransaction?, Object>(
        key: 'revokeKycFromTokenAccount',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .protoServiceTokenServiceRevokeKycFromTokenAccount;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceAssociateTokens extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Associate one or more tokens to an account.
  final HederaTransaction? associateTokens;

  const HederaServiceTokenServiceAssociateTokens({this.associateTokens});

  HederaServiceTokenServiceAssociateTokens copyWith({
    HederaTransaction? associateTokens,
  }) {
    return HederaServiceTokenServiceAssociateTokens(
      associateTokens: associateTokens ?? this.associateTokens,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      associateTokens?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => associateTokens?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'associateTokens': config.encodeMessage(associateTokens)};
  }

  factory HederaServiceTokenServiceAssociateTokens.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceAssociateTokens(
      associateTokens: json.valueTo<HederaTransaction?, Object>(
        key: 'associateTokens',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceAssociateTokens;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceDissociateTokens extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Dissociate one or more tokens from an account.
  final HederaTransaction? dissociateTokens;

  const HederaServiceTokenServiceDissociateTokens({this.dissociateTokens});

  HederaServiceTokenServiceDissociateTokens copyWith({
    HederaTransaction? dissociateTokens,
  }) {
    return HederaServiceTokenServiceDissociateTokens(
      dissociateTokens: dissociateTokens ?? this.dissociateTokens,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      dissociateTokens?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => dissociateTokens?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'dissociateTokens': config.encodeMessage(dissociateTokens)};
  }

  factory HederaServiceTokenServiceDissociateTokens.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceDissociateTokens(
      dissociateTokens: json.valueTo<HederaTransaction?, Object>(
        key: 'dissociateTokens',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceDissociateTokens;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceUpdateTokenFeeSchedule extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Update the custom fee schedule for a token.
  final HederaTransaction? updateTokenFeeSchedule;

  const HederaServiceTokenServiceUpdateTokenFeeSchedule({
    this.updateTokenFeeSchedule,
  });

  HederaServiceTokenServiceUpdateTokenFeeSchedule copyWith({
    HederaTransaction? updateTokenFeeSchedule,
  }) {
    return HederaServiceTokenServiceUpdateTokenFeeSchedule(
      updateTokenFeeSchedule:
          updateTokenFeeSchedule ?? this.updateTokenFeeSchedule,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      updateTokenFeeSchedule?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateTokenFeeSchedule?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'updateTokenFeeSchedule': config.encodeMessage(updateTokenFeeSchedule),
    };
  }

  factory HederaServiceTokenServiceUpdateTokenFeeSchedule.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceUpdateTokenFeeSchedule(
      updateTokenFeeSchedule: json.valueTo<HederaTransaction?, Object>(
        key: 'updateTokenFeeSchedule',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceUpdateTokenFeeSchedule;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServicePauseToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Pause a token.
  final HederaTransaction? pauseToken;

  const HederaServiceTokenServicePauseToken({this.pauseToken});

  HederaServiceTokenServicePauseToken copyWith({
    HederaTransaction? pauseToken,
  }) {
    return HederaServiceTokenServicePauseToken(
      pauseToken: pauseToken ?? this.pauseToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      pauseToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => pauseToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'pauseToken': config.encodeMessage(pauseToken)};
  }

  factory HederaServiceTokenServicePauseToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServicePauseToken(
      pauseToken: json.valueTo<HederaTransaction?, Object>(
        key: 'pauseToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServicePauseToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceUnpauseToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Unpause (resume) a token.
  final HederaTransaction? unpauseToken;

  const HederaServiceTokenServiceUnpauseToken({this.unpauseToken});

  HederaServiceTokenServiceUnpauseToken copyWith({
    HederaTransaction? unpauseToken,
  }) {
    return HederaServiceTokenServiceUnpauseToken(
      unpauseToken: unpauseToken ?? this.unpauseToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      unpauseToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => unpauseToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'unpauseToken': config.encodeMessage(unpauseToken)};
  }

  factory HederaServiceTokenServiceUnpauseToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceUnpauseToken(
      unpauseToken: json.valueTo<HederaTransaction?, Object>(
        key: 'unpauseToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceUnpauseToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceUpdateNfts extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Update multiple non-fungible/unique tokens (NFTs) in a collection.&lt;br/&gt;
  ///      * The NFTs are identified by token identifier and one or more
  ///      * serial numbers.
  ///      * &lt;p&gt;
  ///      * This transaction SHALL update NFT metadata only.&lt;br/&gt;
  ///      * This transaction MUST be signed by the token `metadata_key`.
  final HederaTransaction? updateNfts;

  const HederaServiceTokenServiceUpdateNfts({this.updateNfts});

  HederaServiceTokenServiceUpdateNfts copyWith({
    HederaTransaction? updateNfts,
  }) {
    return HederaServiceTokenServiceUpdateNfts(
      updateNfts: updateNfts ?? this.updateNfts,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      updateNfts?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateNfts?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'updateNfts': config.encodeMessage(updateNfts)};
  }

  factory HederaServiceTokenServiceUpdateNfts.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceUpdateNfts(
      updateNfts: json.valueTo<HederaTransaction?, Object>(
        key: 'updateNfts',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceUpdateNfts;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceRejectToken extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Reject one or more tokens.
  ///      * &lt;p&gt;
  ///      * This transaction SHALL transfer the full balance of one or more tokens
  ///      * from the requesting account to the treasury for each token.&lt;br/&gt;
  ///      * This transfer SHALL NOT charge any custom fee or royalty defined for
  ///      * the token(s) to be rejected.&lt;br/&gt;
  ///      * ### Effects on success
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;If the rejected token is fungible/common, the requesting account
  ///      *       SHALL have a balance of 0 for the rejected token.&lt;br/&gt;
  ///      *       The treasury balance SHALL increase by the amount that the
  ///      *       requesting account decreased.&lt;/li&gt;
  ///      *   &lt;li&gt;If the rejected token is non-fungible/unique the requesting
  ///      *       account SHALL NOT hold the specific serialized token that
  ///      *       is rejected.&lt;br/&gt;
  ///      *       The treasury account SHALL hold each specific serialized token
  ///      *       that was rejected.&lt;/li&gt;
  ///      * &lt;/li&gt;
  final HederaTransaction? rejectToken;

  const HederaServiceTokenServiceRejectToken({this.rejectToken});

  HederaServiceTokenServiceRejectToken copyWith({
    HederaTransaction? rejectToken,
  }) {
    return HederaServiceTokenServiceRejectToken(
      rejectToken: rejectToken ?? this.rejectToken,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      rejectToken?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => rejectToken?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'rejectToken': config.encodeMessage(rejectToken)};
  }

  factory HederaServiceTokenServiceRejectToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceRejectToken(
      rejectToken: json.valueTo<HederaTransaction?, Object>(
        key: 'rejectToken',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceRejectToken;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceAirdropTokens extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Airdrop one or more tokens to one or more accounts.
  ///      * &lt;p&gt;
  ///      * This transaction SHALL distribute tokens from the balance of one or
  ///      * more sending account(s) to the balance of one or more
  ///      * recipient accounts.&lt;br/&gt;
  ///      * Accounts SHALL receive the tokens in one of four ways.
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;An account already associated to the token to be distributed
  ///      *       SHALL receive the airdropped tokens immediately to the
  ///      *       recipient account balance.&lt;/li&gt;
  ///      *   &lt;li&gt;An account with available automatic association slots SHALL
  ///      *       be automatically associated to the token, and SHALL
  ///      *       immediately receive the airdropped tokens to the recipient
  ///      *       account balance.&lt;/li&gt;
  ///      *   &lt;li&gt;An account with "receiver signature required" set SHALL have
  ///      *       a "Pending Airdrop" created and MUST claim that airdrop with
  ///      *       a `claimAirdrop` transaction.&lt;/li&gt;
  ///      *   &lt;li&gt;An account with no available automatic association slots SHALL
  ///      *       have a "Pending Airdrop" created and MUST claim that airdrop
  ///      *       with a `claimAirdrop` transaction. &lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * Any airdrop that completes immediately SHALL be irreversible.&lt;br/&gt;
  ///      * Any airdrop that results in a "Pending Airdrop" MAY be canceled via
  ///      * a `cancelAirdrop` transaction.&lt;br/&gt;
  ///      * All transfer fees (including custom fees and royalties), as well as
  ///      * the rent cost for the first auto-renewal period for any
  ///      * automatic-association slot occupied by the airdropped tokens,
  ///      * SHALL be charged to the account submitting this transaction.
  final HederaTransaction? airdropTokens;

  const HederaServiceTokenServiceAirdropTokens({this.airdropTokens});

  HederaServiceTokenServiceAirdropTokens copyWith({
    HederaTransaction? airdropTokens,
  }) {
    return HederaServiceTokenServiceAirdropTokens(
      airdropTokens: airdropTokens ?? this.airdropTokens,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      airdropTokens?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => airdropTokens?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'airdropTokens': config.encodeMessage(airdropTokens)};
  }

  factory HederaServiceTokenServiceAirdropTokens.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceAirdropTokens(
      airdropTokens: json.valueTo<HederaTransaction?, Object>(
        key: 'airdropTokens',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceAirdropTokens;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceCancelAirdrop extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Cancel one or more pending airdrops.
  ///      * &lt;p&gt;
  ///      * This transaction MUST be signed by _each_ account *sending* an
  ///      * airdrop to be canceled.
  final HederaTransaction? cancelAirdrop;

  const HederaServiceTokenServiceCancelAirdrop({this.cancelAirdrop});

  HederaServiceTokenServiceCancelAirdrop copyWith({
    HederaTransaction? cancelAirdrop,
  }) {
    return HederaServiceTokenServiceCancelAirdrop(
      cancelAirdrop: cancelAirdrop ?? this.cancelAirdrop,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      cancelAirdrop?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => cancelAirdrop?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'cancelAirdrop': config.encodeMessage(cancelAirdrop)};
  }

  factory HederaServiceTokenServiceCancelAirdrop.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceCancelAirdrop(
      cancelAirdrop: json.valueTo<HederaTransaction?, Object>(
        key: 'cancelAirdrop',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceCancelAirdrop;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceTokenServiceClaimAirdrop extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Claim one or more pending airdrops.
  ///      * &lt;p&gt;
  ///      * This transaction MUST be signed by _each_ account **receiving**
  ///      * an airdrop to be claimed.&lt;br&gt;
  ///      * If a "Sender" lacks sufficient balance to fulfill the airdrop at
  ///      * the time the claim is made, that claim SHALL fail.
  final HederaTransaction? claimAirdrop;

  const HederaServiceTokenServiceClaimAirdrop({this.claimAirdrop});

  HederaServiceTokenServiceClaimAirdrop copyWith({
    HederaTransaction? claimAirdrop,
  }) {
    return HederaServiceTokenServiceClaimAirdrop(
      claimAirdrop: claimAirdrop ?? this.claimAirdrop,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      claimAirdrop?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => claimAirdrop?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'claimAirdrop': config.encodeMessage(claimAirdrop)};
  }

  factory HederaServiceTokenServiceClaimAirdrop.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceClaimAirdrop(
      claimAirdrop: json.valueTo<HederaTransaction?, Object>(
        key: 'claimAirdrop',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceClaimAirdrop;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceScheduleServiceCreateSchedule extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///    * Create a new Schedule.
  ///    * &lt;p&gt;
  ///    * If all signature requirements are met with this transaction, the
  ///    * scheduled transaction MAY execute immediately.
  final HederaTransaction? createSchedule;

  const HederaServiceScheduleServiceCreateSchedule({this.createSchedule});

  HederaServiceScheduleServiceCreateSchedule copyWith({
    HederaTransaction? createSchedule,
  }) {
    return HederaServiceScheduleServiceCreateSchedule(
      createSchedule: createSchedule ?? this.createSchedule,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      createSchedule?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createSchedule?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'createSchedule': config.encodeMessage(createSchedule)};
  }

  factory HederaServiceScheduleServiceCreateSchedule.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceScheduleServiceCreateSchedule(
      createSchedule: json.valueTo<HederaTransaction?, Object>(
        key: 'createSchedule',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceScheduleServiceCreateSchedule;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceScheduleServiceSignSchedule extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///    * Add signatures to an existing schedule.
  ///    * &lt;p&gt;
  ///    * Signatures on this transaction SHALL be added to the set of active
  ///    * signatures on the schedule, and MAY result in execution of the
  ///    * scheduled transaction if all signature requirements are met.
  final HederaTransaction? signSchedule;

  const HederaServiceScheduleServiceSignSchedule({this.signSchedule});

  HederaServiceScheduleServiceSignSchedule copyWith({
    HederaTransaction? signSchedule,
  }) {
    return HederaServiceScheduleServiceSignSchedule(
      signSchedule: signSchedule ?? this.signSchedule,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      signSchedule?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => signSchedule?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'signSchedule': config.encodeMessage(signSchedule)};
  }

  factory HederaServiceScheduleServiceSignSchedule.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceScheduleServiceSignSchedule(
      signSchedule: json.valueTo<HederaTransaction?, Object>(
        key: 'signSchedule',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceScheduleServiceSignSchedule;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceScheduleServiceDeleteSchedule extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///    * Mark an existing schedule deleted.
  ///    * &lt;p&gt;
  ///    * Once deleted a schedule SHALL NOT be executed and any subsequent
  ///    * `scheduleSign` transaction SHALL fail.
  final HederaTransaction? deleteSchedule;

  const HederaServiceScheduleServiceDeleteSchedule({this.deleteSchedule});

  HederaServiceScheduleServiceDeleteSchedule copyWith({
    HederaTransaction? deleteSchedule,
  }) {
    return HederaServiceScheduleServiceDeleteSchedule(
      deleteSchedule: deleteSchedule ?? this.deleteSchedule,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      deleteSchedule?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deleteSchedule?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'deleteSchedule': config.encodeMessage(deleteSchedule)};
  }

  factory HederaServiceScheduleServiceDeleteSchedule.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceScheduleServiceDeleteSchedule(
      deleteSchedule: json.valueTo<HederaTransaction?, Object>(
        key: 'deleteSchedule',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceScheduleServiceDeleteSchedule;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceFreezeServiceFreeze extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Freeze, cancel, or prepare a freeze.
  ///      * This single transaction performs all of the functions supported
  ///      * by the network freeze service. These functions include actions to
  ///      * prepare an upgrade, prepare a telemetry upgrade, freeze the network,
  ///      * freeze the network for upgrade, or abort a scheduled freeze.
  ///      * &lt;p&gt;
  ///      * The actual freeze action SHALL be determined by the `freeze_type` field
  ///      * of the `FreezeTransactionBody`.&lt;br/&gt;
  ///      * The transaction body MUST be a `FreezeTransactionBody`.
  final HederaTransaction? freeze;

  const HederaServiceFreezeServiceFreeze({this.freeze});

  HederaServiceFreezeServiceFreeze copyWith({HederaTransaction? freeze}) {
    return HederaServiceFreezeServiceFreeze(freeze: freeze ?? this.freeze);
  }

  @override
  ProtoMessageConfig protoConfig() =>
      freeze?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => freeze?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'freeze': config.encodeMessage(freeze)};
  }

  factory HederaServiceFreezeServiceFreeze.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFreezeServiceFreeze(
      freeze: json.valueTo<HederaTransaction?, Object>(
        key: 'freeze',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFreezeServiceFreeze;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceCreateContract extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Create a new smart contract.
  ///      * &lt;p&gt;
  ///      * If this transaction succeeds, the `ContractID` for the new smart
  ///      * contract SHALL be set in the transaction receipt.&lt;br/&gt;
  ///      * The contract is defined by the initial bytecode (or `initcode`).
  ///      * The `initcode` SHALL be provided either in a previously created file,
  ///      * or in the transaction body itself for very small contracts.&lt;br/&gt;
  ///      * As part of contract creation, the constructor defined for the new
  ///      * smart contract SHALL run with the parameters provided in
  ///      * the `constructorParameters` field.&lt;br/&gt;
  ///      * The gas to "power" that constructor MUST be provided via the `gas`
  ///      * field, and SHALL be charged to the payer for this transaction.&lt;br/&gt;
  ///      * If the contract _constructor_ stores information, it is charged gas for
  ///      * that storage. There is a separate fee in HBAR to maintain that storage
  ///      * until the expiration, and that fee SHALL be added to this transaction
  ///      * as part of the _transaction fee_, rather than gas.
  final HederaTransaction? createContract;

  const HederaServiceSmartContractServiceCreateContract({this.createContract});

  HederaServiceSmartContractServiceCreateContract copyWith({
    HederaTransaction? createContract,
  }) {
    return HederaServiceSmartContractServiceCreateContract(
      createContract: createContract ?? this.createContract,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      createContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createContract?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'createContract': config.encodeMessage(createContract)};
  }

  factory HederaServiceSmartContractServiceCreateContract.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceCreateContract(
      createContract: json.valueTo<HederaTransaction?, Object>(
        key: 'createContract',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceCreateContract;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceUpdateContract extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Modify a smart contract.&lt;br/&gt;
  ///      * Any change other than updating the expiration time requires that the
  ///      * contract be modifiable (has a valid `adminKey`) and that the
  ///      * transaction be signed by the `adminKey`
  ///      * &lt;p&gt;
  ///      * Fields _not set_ on the request SHALL NOT be modified.
  final HederaTransaction? updateContract;

  const HederaServiceSmartContractServiceUpdateContract({this.updateContract});

  HederaServiceSmartContractServiceUpdateContract copyWith({
    HederaTransaction? updateContract,
  }) {
    return HederaServiceSmartContractServiceUpdateContract(
      updateContract: updateContract ?? this.updateContract,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      updateContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateContract?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'updateContract': config.encodeMessage(updateContract)};
  }

  factory HederaServiceSmartContractServiceUpdateContract.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceUpdateContract(
      updateContract: json.valueTo<HederaTransaction?, Object>(
        key: 'updateContract',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceUpdateContract;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceContractCallMethod
    extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Call a function of a given smart contract, providing function parameter
  ///      * inputs as needed.
  ///      * &lt;p&gt;
  ///      * Resource ("gas") charges SHALL include all relevant fees incurred by
  ///      * the contract execution, including any storage required.&lt;br/&gt;
  ///      * The total transaction fee SHALL incorporate all of the "gas" actually
  ///      * consumed as well as the standard fees for transaction handling,
  ///      * data transfers, signature verification, etc...
  final HederaTransaction? contractCallMethod;

  const HederaServiceSmartContractServiceContractCallMethod({
    this.contractCallMethod,
  });

  HederaServiceSmartContractServiceContractCallMethod copyWith({
    HederaTransaction? contractCallMethod,
  }) {
    return HederaServiceSmartContractServiceContractCallMethod(
      contractCallMethod: contractCallMethod ?? this.contractCallMethod,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      contractCallMethod?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => contractCallMethod?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'contractCallMethod': config.encodeMessage(contractCallMethod)};
  }

  factory HederaServiceSmartContractServiceContractCallMethod.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceContractCallMethod(
      contractCallMethod: json.valueTo<HederaTransaction?, Object>(
        key: 'contractCallMethod',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .protoServiceSmartContractServiceContractCallMethod;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceDeleteContract extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete a smart contract, and transfer any remaining HBAR balance
  ///      * to a designated account.
  ///      * &lt;p&gt;
  ///      * If this call succeeds then all subsequent calls to that smart
  ///      * contract SHALL fail.&lt;br/&gt;
  final HederaTransaction? deleteContract;

  const HederaServiceSmartContractServiceDeleteContract({this.deleteContract});

  HederaServiceSmartContractServiceDeleteContract copyWith({
    HederaTransaction? deleteContract,
  }) {
    return HederaServiceSmartContractServiceDeleteContract(
      deleteContract: deleteContract ?? this.deleteContract,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      deleteContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deleteContract?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'deleteContract': config.encodeMessage(deleteContract)};
  }

  factory HederaServiceSmartContractServiceDeleteContract.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceDeleteContract(
      deleteContract: json.valueTo<HederaTransaction?, Object>(
        key: 'deleteContract',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceDeleteContract;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceSystemDelete extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete a smart contract, as a system-initiated deletion, this
  ///      * SHALL NOT transfer balances.
  ///      * &lt;blockquote&gt;
  ///      * This call is an administrative function of the Hedera network, and
  ///      * SHALL require network administration authorization.&lt;br/&gt;
  ///      * This transaction MUST be signed by one of the network administration
  ///      * accounts (typically `0.0.2` through `0.0.59`, as defined in the
  ///      * `api-permission.properties` file).
  ///      * &lt;/blockquote&gt;
  ///      * If this call succeeds then all subsequent calls to that smart
  ///      * contract SHALL fail.&lt;br/&gt;
  final HederaTransaction? systemDelete;

  const HederaServiceSmartContractServiceSystemDelete({this.systemDelete});

  HederaServiceSmartContractServiceSystemDelete copyWith({
    HederaTransaction? systemDelete,
  }) {
    return HederaServiceSmartContractServiceSystemDelete(
      systemDelete: systemDelete ?? this.systemDelete,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      systemDelete?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => systemDelete?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'systemDelete': config.encodeMessage(systemDelete)};
  }

  factory HederaServiceSmartContractServiceSystemDelete.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceSystemDelete(
      systemDelete: json.valueTo<HederaTransaction?, Object>(
        key: 'systemDelete',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceSystemDelete;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceSystemUndelete extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Un-Delete a smart contract, returning it (mostly) to its state
  ///      * prior to deletion.
  ///      * &lt;p&gt;
  ///      * The contract to be restored MUST have been deleted via `systemDelete`.
  ///      * If the contract was deleted via `deleteContract`, it
  ///      * SHALL NOT be recoverable.
  ///      * &lt;blockquote&gt;
  ///      * This call is an administrative function of the Hedera network, and
  ///      * SHALL require network administration authorization.&lt;br/&gt;
  ///      * This transaction MUST be signed by one of the network administration
  ///      * accounts (typically `0.0.2` through `0.0.59`, as defined in the
  ///      * `api-permission.properties` file).
  ///      * &lt;/blockquote&gt;
  ///      * If this call succeeds then subsequent calls to that smart
  ///      * contract MAY succeed.&lt;br/&gt;
  final HederaTransaction? systemUndelete;

  const HederaServiceSmartContractServiceSystemUndelete({this.systemUndelete});

  HederaServiceSmartContractServiceSystemUndelete copyWith({
    HederaTransaction? systemUndelete,
  }) {
    return HederaServiceSmartContractServiceSystemUndelete(
      systemUndelete: systemUndelete ?? this.systemUndelete,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      systemUndelete?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => systemUndelete?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'systemUndelete': config.encodeMessage(systemUndelete)};
  }

  factory HederaServiceSmartContractServiceSystemUndelete.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceSystemUndelete(
      systemUndelete: json.valueTo<HederaTransaction?, Object>(
        key: 'systemUndelete',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceSystemUndelete;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceCallEthereum extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Make an Ethereum transaction "call" with all data in Ethereum formats,
  ///      * including the contract alias.
  ///      * &lt;p&gt;
  ///      * Call data MAY be in the transaction, or stored within a "File".&lt;br/&gt;
  ///      * The caller MAY offer additional gas above what is offered in the call
  ///      * data, but MAY be charged up to 80% of that value if the amount required
  ///      * is less than this "floor" amount.
  final HederaTransaction? callEthereum;

  const HederaServiceSmartContractServiceCallEthereum({this.callEthereum});

  HederaServiceSmartContractServiceCallEthereum copyWith({
    HederaTransaction? callEthereum,
  }) {
    return HederaServiceSmartContractServiceCallEthereum(
      callEthereum: callEthereum ?? this.callEthereum,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      callEthereum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => callEthereum?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'callEthereum': config.encodeMessage(callEthereum)};
  }

  factory HederaServiceSmartContractServiceCallEthereum.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceCallEthereum(
      callEthereum: json.valueTo<HederaTransaction?, Object>(
        key: 'callEthereum',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceCallEthereum;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceSmartContractServiceHookStore extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Update zero or more slots of an EVM hook's storage.
  final HederaTransaction? hookStore;

  const HederaServiceSmartContractServiceHookStore({this.hookStore});

  HederaServiceSmartContractServiceHookStore copyWith({
    HederaTransaction? hookStore,
  }) {
    return HederaServiceSmartContractServiceHookStore(
      hookStore: hookStore ?? this.hookStore,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      hookStore?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => hookStore?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'hookStore': config.encodeMessage(hookStore)};
  }

  factory HederaServiceSmartContractServiceHookStore.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceHookStore(
      hookStore: json.valueTo<HederaTransaction?, Object>(
        key: 'hookStore',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceHookStore;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceCreateAccount extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// The following queries are permanently removed.
  /// getStakersByAccountID, getFastTransactionRecord
  /// *
  ///      * Create a new account by submitting the transaction
  final HederaTransaction? createAccount;

  const HederaServiceCryptoServiceCreateAccount({this.createAccount});

  HederaServiceCryptoServiceCreateAccount copyWith({
    HederaTransaction? createAccount,
  }) {
    return HederaServiceCryptoServiceCreateAccount(
      createAccount: createAccount ?? this.createAccount,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      createAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createAccount?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'createAccount': config.encodeMessage(createAccount)};
  }

  factory HederaServiceCryptoServiceCreateAccount.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceCreateAccount(
      createAccount: json.valueTo<HederaTransaction?, Object>(
        key: 'createAccount',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceCreateAccount;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceUpdateAccount extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Update an account by submitting the transaction
  final HederaTransaction? updateAccount;

  const HederaServiceCryptoServiceUpdateAccount({this.updateAccount});

  HederaServiceCryptoServiceUpdateAccount copyWith({
    HederaTransaction? updateAccount,
  }) {
    return HederaServiceCryptoServiceUpdateAccount(
      updateAccount: updateAccount ?? this.updateAccount,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      updateAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => updateAccount?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'updateAccount': config.encodeMessage(updateAccount)};
  }

  factory HederaServiceCryptoServiceUpdateAccount.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceUpdateAccount(
      updateAccount: json.valueTo<HederaTransaction?, Object>(
        key: 'updateAccount',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceUpdateAccount;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceCryptoTransfer extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Initiate a transfer by submitting the transaction
  final HederaTransaction? cryptoTransfer;

  const HederaServiceCryptoServiceCryptoTransfer({this.cryptoTransfer});

  HederaServiceCryptoServiceCryptoTransfer copyWith({
    HederaTransaction? cryptoTransfer,
  }) {
    return HederaServiceCryptoServiceCryptoTransfer(
      cryptoTransfer: cryptoTransfer ?? this.cryptoTransfer,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      cryptoTransfer?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => cryptoTransfer?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'cryptoTransfer': config.encodeMessage(cryptoTransfer)};
  }

  factory HederaServiceCryptoServiceCryptoTransfer.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceCryptoTransfer(
      cryptoTransfer: json.valueTo<HederaTransaction?, Object>(
        key: 'cryptoTransfer',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceCryptoTransfer;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceCryptoDelete extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete an account by submitting the transaction
  final HederaTransaction? cryptoDelete;

  const HederaServiceCryptoServiceCryptoDelete({this.cryptoDelete});

  HederaServiceCryptoServiceCryptoDelete copyWith({
    HederaTransaction? cryptoDelete,
  }) {
    return HederaServiceCryptoServiceCryptoDelete(
      cryptoDelete: cryptoDelete ?? this.cryptoDelete,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      cryptoDelete?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => cryptoDelete?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'cryptoDelete': config.encodeMessage(cryptoDelete)};
  }

  factory HederaServiceCryptoServiceCryptoDelete.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceCryptoDelete(
      cryptoDelete: json.valueTo<HederaTransaction?, Object>(
        key: 'cryptoDelete',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceCryptoDelete;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceApproveAllowances extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Add one or more approved allowances for spenders to transfer the paying
  ///      * account's hbar or tokens.
  final HederaTransaction? approveAllowances;

  const HederaServiceCryptoServiceApproveAllowances({this.approveAllowances});

  HederaServiceCryptoServiceApproveAllowances copyWith({
    HederaTransaction? approveAllowances,
  }) {
    return HederaServiceCryptoServiceApproveAllowances(
      approveAllowances: approveAllowances ?? this.approveAllowances,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      approveAllowances?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => approveAllowances?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'approveAllowances': config.encodeMessage(approveAllowances)};
  }

  factory HederaServiceCryptoServiceApproveAllowances.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceApproveAllowances(
      approveAllowances: json.valueTo<HederaTransaction?, Object>(
        key: 'approveAllowances',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceApproveAllowances;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceDeleteAllowances extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete one or more of the specific approved NFT serial numbers on an
  ///      * owner account.
  final HederaTransaction? deleteAllowances;

  const HederaServiceCryptoServiceDeleteAllowances({this.deleteAllowances});

  HederaServiceCryptoServiceDeleteAllowances copyWith({
    HederaTransaction? deleteAllowances,
  }) {
    return HederaServiceCryptoServiceDeleteAllowances(
      deleteAllowances: deleteAllowances ?? this.deleteAllowances,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      deleteAllowances?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deleteAllowances?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'deleteAllowances': config.encodeMessage(deleteAllowances)};
  }

  factory HederaServiceCryptoServiceDeleteAllowances.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceDeleteAllowances(
      deleteAllowances: json.valueTo<HederaTransaction?, Object>(
        key: 'deleteAllowances',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceDeleteAllowances;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceAddLiveHash extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Add a livehash
  ///      * &lt;blockquote&gt;Important&lt;blockquote&gt;
  ///      * This transaction is obsolete, not supported, and SHALL fail with a
  ///      * pre-check result of `NOT_SUPPORTED`.&lt;/blockquote&gt;&lt;/blockquote&gt;
  final HederaTransaction? addLiveHash;

  const HederaServiceCryptoServiceAddLiveHash({this.addLiveHash});

  HederaServiceCryptoServiceAddLiveHash copyWith({
    HederaTransaction? addLiveHash,
  }) {
    return HederaServiceCryptoServiceAddLiveHash(
      addLiveHash: addLiveHash ?? this.addLiveHash,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      addLiveHash?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => addLiveHash?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'addLiveHash': config.encodeMessage(addLiveHash)};
  }

  factory HederaServiceCryptoServiceAddLiveHash.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceAddLiveHash(
      addLiveHash: json.valueTo<HederaTransaction?, Object>(
        key: 'addLiveHash',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceAddLiveHash;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

class HederaServiceCryptoServiceDeleteLiveHash extends HederaProtoMessage
    with
        Equality,
        IHederaServiceMessage<
          proto_transaction_response.HederaTransactionResponse
        > {
  /// *
  ///      * Delete a livehash
  ///      * &lt;blockquote&gt;Important&lt;blockquote&gt;
  ///      * This transaction is obsolete, not supported, and SHALL fail with a
  ///      * pre-check result of `NOT_SUPPORTED`.&lt;/blockquote&gt;&lt;/blockquote&gt;
  final HederaTransaction? deleteLiveHash;

  const HederaServiceCryptoServiceDeleteLiveHash({this.deleteLiveHash});

  HederaServiceCryptoServiceDeleteLiveHash copyWith({
    HederaTransaction? deleteLiveHash,
  }) {
    return HederaServiceCryptoServiceDeleteLiveHash(
      deleteLiveHash: deleteLiveHash ?? this.deleteLiveHash,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      deleteLiveHash?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => deleteLiveHash?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'deleteLiveHash': config.encodeMessage(deleteLiveHash)};
  }

  factory HederaServiceCryptoServiceDeleteLiveHash.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceDeleteLiveHash(
      deleteLiveHash: json.valueTo<HederaTransaction?, Object>(
        key: 'deleteLiveHash',
        parse:
            (v) => HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceDeleteLiveHash;
  @override
  proto_transaction_response.HederaTransactionResponse onServiceResponse(
    List<int> bytes,
  ) {
    return proto_transaction_response.HederaTransactionResponse.deserialize(
      bytes,
    );
  }
}

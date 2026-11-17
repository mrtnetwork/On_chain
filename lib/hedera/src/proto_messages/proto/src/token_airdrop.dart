import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Airdrop
///  * Messages used to implement a transaction to "airdrop" tokens.&lt;br/&gt;
///  * An "airdrop" is a distribution of tokens from a funding account
///  * to one or more recipient accounts, ideally with no action required
///  * by the recipient account(s).
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Airdrop one or more tokens to one or more accounts.
///  *
///  * ### Effects
///  * This distributes tokens from the balance of one or more sending account(s)
///  * to the balance of one or more recipient accounts. Accounts MAY receive the
///  * tokens in one of four ways.
///  *
///  *  - An account already associated to the token to be distributed SHALL
///  *    receive the airdropped tokens immediately to the recipient account
///  *    balance.&lt;br/&gt;
///  *    The fee for this transfer SHALL include the transfer, the airdrop fee,
///  *    and any custom fees.
///  *  - An account with available automatic association slots SHALL be
///  *    automatically associated to the token, and SHALL immediately receive
///  *    the airdropped tokens to the recipient account balance.&lt;br/&gt;
///  *    The fee for this transfer SHALL include the transfer, the association,
///  *    the cost to renew that association once, the airdrop fee, and
///  *    any custom fees.
///  *  - An account with "receiver signature required" set SHALL have a
///  *    "Pending Airdrop" created and must claim that airdrop with a
///  *    `claimAirdrop` transaction.&lt;br/&gt;
///  *    The fee for this transfer SHALL include the transfer, the association,
///  *    the cost to renew that association once, the airdrop fee, and
///  *    any custom fees.&lt;br/&gt;
///  *    If the pending airdrop is not claimed immediately, the `sender` SHALL
///  *    pay the cost to renew the token association, and the cost to maintain
///  *    the pending airdrop, until the pending airdrop is claimed or cancelled.
///  *  - An account with no available automatic association slots SHALL have a
///  *    "Pending Airdrop" created and must claim that airdrop with a
///  *    `claimAirdrop` transaction.&lt;br/&gt;
///  *    The fee for this transfer SHALL include the transfer, the association,
///  *    the cost to renew that association once, the airdrop fee, and any custom
///  *    fees.&lt;br/&gt;
///  *    If the pending airdrop is not claimed immediately, the `sender` SHALL
///  *    pay the cost to renew the token association, and the cost to maintain
///  *    the pending airdrop, until the pending airdrop is claimed or cancelled.
///  *
///  * If an airdrop would create a pending airdrop for a fungible/common token,
///  * and a pending airdrop for the same sender, receiver, and token already
///  * exists, the existing pending airdrop SHALL be updated to add the new
///  * amount to the existing airdrop, rather than creating
///  * a new pending airdrop.&lt;br/&gt;
///  * Any airdrop that completes immediately SHALL be irreversible. Any airdrop
///  * that results in a "Pending Airdrop" MAY be canceled via a `cancelAirdrop`
///  * transaction.&lt;br/&gt;
///  * All transfer fees (including custom fees and royalties), as well as the
///  * rent cost for the first auto-renewal period for any automatic-association
///  * slot occupied by the airdropped tokens, SHALL be charged to the account
///  * paying for this transaction.&lt;br/&gt;
///  *
///  * ### Block Stream Effects
///  * - Each successful transfer SHALL be recorded in `token_transfer_list`
///  *   for the transaction record.
///  * - Each successful transfer that consumes an automatic association slot
///  *   SHALL populate the `automatic_association` field for the record.
///  * - Each pending transfer _created_ SHALL be added to the
///  *   `pending_airdrops` field for the record.
///  * - Each pending transfer _updated_ SHALL be added to the
///  *   `pending_airdrops` field for the record.
class HederaTokenAirdropTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of token transfers representing one or more airdrops.
  ///      * &lt;p&gt;
  ///      * The sender for each transfer MUST have sufficient balance to complete
  ///      * the transfers.&lt;br/&gt;
  ///      * All token transfers MUST successfully transfer tokens or create a
  ///      * pending airdrop for this transaction to succeed.&lt;br/&gt;
  ///      * This list MUST contain between 1 and 10 transfers, inclusive.
  ///      * &lt;p&gt;
  ///      * Note that each transfer of fungible/common tokens requires both a debit
  ///      * and a credit, so each _fungible_ token transfer MUST have _balanced_
  ///      * entries in the TokenTransferList for that transfer.
  final List<proto_basic_types.HederaTokenTransferList> tokenTransfers;

  const HederaTokenAirdropTransactionBody({
    this.tokenTransfers = const [],
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
        tokenTransfers,
      ];


HederaTokenAirdropTransactionBody copyWith(
{List<proto_basic_types.HederaTokenTransferList>? tokenTransfers,

}) {
    return HederaTokenAirdropTransactionBody(
tokenTransfers: tokenTransfers ?? this.tokenTransfers,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token_transfers': tokenTransfers.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTokenAirdropTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenAirdropTransactionBody(
      tokenTransfers: (json.valueEnsureAsList<dynamic>('token_transfers', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaTokenTransferList, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaTokenTransferList.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTokenAirdropTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenAirdropTransactionBody(
      tokenTransfers: decode.getListOfBytes(1).map((b) => proto_basic_types.HederaTokenTransferList.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenAirdropTransactionBody;

}



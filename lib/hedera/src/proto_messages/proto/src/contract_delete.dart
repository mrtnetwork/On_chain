import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Contract Delete
///  * Delete a smart contract, transferring any remaining balance to a
///  * designated account.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Delete a smart contract, and transfer any remaining HBAR balance to a
///  * designated account.
///  *
///  * If this call succeeds then all subsequent calls to that smart contract
///  * SHALL execute the `0x0` opcode, as required for EVM equivalence.
///  *
///  * ### Requirements
///  *  - An account or smart contract MUST be designated to receive all remaining
///  *    account balances.
///  *  - The smart contract MUST have an admin key set. If the contract does not
///  *    have `admin_key` set, then this transaction SHALL fail and response code
///  *    `MODIFYING_IMMUTABLE_CONTRACT` SHALL be set.
///  *  - If `admin_key` is, or contains, an empty `KeyList` key, it SHALL be
///  *    treated the same as an admin key that is not set.
///  *  - The `Key` set for `admin_key` on the smart contract MUST have a valid
///  *    signature set on this transaction.
///  *  - The designated receiving account MAY have `receiver_sig_required` set. If
///  *    that field is set, the receiver account MUST also sign this transaction.
///  *  - The field `permanent_removal` MUST NOT be set. That field is reserved for
///  *    internal system use when purging the smart contract from state. Any user
///  *    transaction with that field set SHALL be rejected and a response code
///  *    `PERMANENT_REMOVAL_REQUIRES_SYSTEM_INITIATION` SHALL be set.
///  *
///  * ### Block Stream Effects
///  * None
class HederaContractDeleteTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * The id of the contract to be deleted.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaContractID? contractID;

    /// *
  ///          * An Account ID recipient.
  ///          * &lt;p&gt;
  ///          * This account SHALL receive all HBAR and other tokens still owned by
  ///          * the contract that is removed.
  final proto_basic_types.HederaAccountID? transferAccountID;

    /// *
  ///          * A contract ID recipient.
  ///          * &lt;p&gt;
  ///          * This contract SHALL receive all HBAR and other tokens still owned by
  ///          * the contract that is removed.
  final proto_basic_types.HederaContractID? transferContractID;

    /// *
  ///      * A flag indicating that this transaction is "synthetic"; initiated by the
  ///      * node software.
  ///      * &lt;p&gt;
  ///      * The consensus nodes create such "synthetic" transactions to both to
  ///      * properly manage state changes and to communicate those changes to other
  ///      * systems via the Block Stream.&lt;br/&gt;
  ///      * A user-initiated transaction MUST NOT set this flag.
  final bool? permanentRemoval;

  const HederaContractDeleteTransactionBody({
    this.contractID,
    this.transferAccountID,
    this.transferContractID,
    this.permanentRemoval,
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
        ProtoFieldConfig.bool(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        contractID,
        transferAccountID,
        transferContractID,
        permanentRemoval,
      ];


HederaContractDeleteTransactionBody copyWith(
{proto_basic_types.HederaContractID? contractID,

proto_basic_types.HederaAccountID? transferAccountID,

proto_basic_types.HederaContractID? transferContractID,

bool? permanentRemoval,

}) {
    return HederaContractDeleteTransactionBody(
contractID: contractID ?? this.contractID,
transferAccountID: transferAccountID ?? this.transferAccountID,
transferContractID: transferContractID ?? this.transferContractID,
permanentRemoval: permanentRemoval ?? this.permanentRemoval,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contractID': config.encodeMessage(contractID),
      'transferAccountID': config.encodeMessage(transferAccountID),
      'transferContractID': config.encodeMessage(transferContractID),
      'permanent_removal': permanentRemoval,
    };
  }


  factory HederaContractDeleteTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractDeleteTransactionBody(
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transferAccountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'transferAccountID',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transferContractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'transferContractID',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      permanentRemoval: json.valueAsBool<bool?>('permanent_removal', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaContractDeleteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractDeleteTransactionBody(
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(1, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      transferAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      transferContractID: decode.messageTo<proto_basic_types.HederaContractID?>(3, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      permanentRemoval: decode.getBool<bool?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractDeleteTransactionBody;

}



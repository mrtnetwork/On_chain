import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Crypto Transfer
///  * Transaction to transfer HBAR between accounts, or between accounts and
///  * smart contracts.
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
///  * Transfer HBAR and/or other tokens among two or more accounts and/or smart
///  * contracts.
///  *
///  * Transfers of HBAR or fungible/common tokens in this transaction are
///  * structured as a "double-entry" transfer list which debits one or more
///  * accounts, and separately credits one or more accounts. Each such transfer
///  * list may specify up to 10 individual credits or debits.&lt;br/&gt;
///  * Transfers of non-fungible/unique tokens in this transaction are
///  * structured as a "single-entry" transfer list, which both debits one account
///  * and credits another account in a single entry.
///  *
///  * At least one transfer MUST be present, this MAY be an HBAR transfer in
///  * `transfers`, or MAY be a token transfer in `tokenTransfers`.&lt;br/&gt;
///  * Either `transfers` or `tokenTransfers` MAY be unset, provided the other
///  * is set and not empty.&lt;br/&gt;
///  * If any one account with a debit in any transfer list holds insufficient
///  * balance to complete the transfer, the entire transaction SHALL fail, and
///  * all transfers SHALL NOT be completed.&lt;br/&gt;
///  * If any one account that is _sending_ an individual non-fungible/unique (NFT)
///  * token does not currently hold that unique NFT, the entire transaction SHALL
///  * FAIL, and all transfers SHALL NOT be completed.
///  * The transaction fee SHALL be charged for a transaction that fails due to
///  * insufficient balance or not holding the NFT to be transferred.&lt;br/&gt;
///  * Each account with any debit amounts in any transfer list MUST sign this
///  * transaction.&lt;br/&gt;
///  * Each account with any credit amounts in any transfer list that also has the
///  * `receiverSigRequired` flag set MUST sign this transaction.
///  *
///  * ### Block Stream Effects
///  * All debits and credits completed by this transaction SHALL be included in
///  * the transaction result transfer list.&lt;br/&gt;
///  * Multiple fungible/common debits from one account, or credits to one account,
///  * MAY be consolidated to a single debit or credit entry in the
///  * transaction result.&lt;br/&gt;
///  * Multiple non-fungible/unique transfers SHALL NOT be consolidated in the
///  * transaction result.
class HederaCryptoTransferTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A list of HBAR transfers.
  ///      * &lt;p&gt;
  ///      * Each transfer in this list MUST be denominated in tinybar.
  final proto_basic_types.HederaTransferList? transfers;

  /// *
  ///      * One or more lists of token transfers.
  ///      * &lt;p&gt;
  ///      * This list MUST NOT contain more than 10 entries.&lt;br/&gt;
  ///      * If custom fees must be charged, the fee SHALL be assessed against the
  ///      * effective "payer" for this transaction.&lt;br/&gt;
  ///      * If the effective "payer" for this transaction lacks sufficient balance
  ///      * to pay custom fees assessed, the entire transaction SHALL fail with a
  ///      * response code `INSUFFICIENT_PAYER_BALANCE_FOR_CUSTOM_FEE`.
  final List<proto_basic_types.HederaTokenTransferList> tokenTransfers;

  const HederaCryptoTransferTransactionBody({
    this.transfers,
    this.tokenTransfers = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transfers, tokenTransfers];

  HederaCryptoTransferTransactionBody copyWith({
    proto_basic_types.HederaTransferList? transfers,

    List<proto_basic_types.HederaTokenTransferList>? tokenTransfers,
  }) {
    return HederaCryptoTransferTransactionBody(
      transfers: transfers ?? this.transfers,
      tokenTransfers: tokenTransfers ?? this.tokenTransfers,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transfers': config.encodeMessage(transfers),
      'tokenTransfers':
          tokenTransfers.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaCryptoTransferTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoTransferTransactionBody(
      transfers: json.valueTo<proto_basic_types.HederaTransferList?, Object>(
        key: 'transfers',
        parse:
            (v) => proto_basic_types.HederaTransferList.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenTransfers:
          (json.valueEnsureAsList<dynamic>(
                'tokenTransfers',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaTokenTransferList,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaTokenTransferList.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaCryptoTransferTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoTransferTransactionBody(
      transfers: decode.messageTo<proto_basic_types.HederaTransferList?>(
        1,
        (b) => proto_basic_types.HederaTransferList.deserialize(b),
      ),
      tokenTransfers:
          decode
              .getListOfBytes(2)
              .map(
                (b) => proto_basic_types.HederaTokenTransferList.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoTransferTransactionBody;
}

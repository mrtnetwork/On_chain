import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Cancel Airdrop
///  * Messages used to implement a transaction to cancel a pending airdrop.
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
///  * Token cancel airdrop&lt;br/&gt;
///  * Remove one or more pending airdrops from state on behalf of the
///  * sender(s) for each airdrop.
///  *
///  * Each pending airdrop canceled SHALL be removed from state and
///  * SHALL NOT be available to claim.&lt;br/&gt;
///  * Each cancellation SHALL be represented in the transaction body and
///  * SHALL NOT be restated in the record file.&lt;br/&gt;
///  * All cancellations MUST succeed for this transaction to succeed.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenCancelAirdropTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A list of one or more pending airdrop identifiers.&lt;br/&gt;
  ///      * This list declares the set of pending airdrop entries that the client
  ///      * wishes to cancel; on success all listed pending airdrop entries
  ///      * will be removed.
  ///      * &lt;p&gt;
  ///      * This transaction MUST be signed by the account identified by a
  ///      * `sender_id` for each entry in this list.&lt;br/&gt;
  ///      * This list MUST NOT have any duplicate entries.&lt;br/&gt;
  ///      * This list MUST contain between 1 and 10 entries, inclusive.
  final List<proto_basic_types.HederaPendingAirdropId> pendingAirdrops;

  const HederaTokenCancelAirdropTransactionBody({
    this.pendingAirdrops = const [],
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
        pendingAirdrops,
      ];


HederaTokenCancelAirdropTransactionBody copyWith(
{List<proto_basic_types.HederaPendingAirdropId>? pendingAirdrops,

}) {
    return HederaTokenCancelAirdropTransactionBody(
pendingAirdrops: pendingAirdrops ?? this.pendingAirdrops,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'pending_airdrops': pendingAirdrops.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTokenCancelAirdropTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenCancelAirdropTransactionBody(
      pendingAirdrops: (json.valueEnsureAsList<dynamic>('pending_airdrops', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaPendingAirdropId, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaPendingAirdropId.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTokenCancelAirdropTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenCancelAirdropTransactionBody(
      pendingAirdrops: decode.getListOfBytes(1).map((b) => proto_basic_types.HederaPendingAirdropId.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenCancelAirdropTransactionBody;

}



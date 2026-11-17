import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Unchecked Submit
///  * Submit a transaction to the network, bypassing all but the most minimal
///  * validation.
///  *
///  * &gt; Important
///  * &gt;&gt; This transaction is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any transaction of this type that is submitted SHALL fail with a
///  * &gt;&gt; `PRE_CHECK` result of `NOT_SUPPORTED`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Submit an arbitrary (serialized) Transaction to the network
///  * without pre-check.
///  *
///  * This transaction SHALL require `superuser` privileges
///  * (e.g. the `treasury` or `systemAdmin` accounts).
class HederaUncheckedSubmitBody extends HederaProtoMessage with Equality {
    /// *
  ///      * The serialized bytes of a `Transaction`.
  ///      * &lt;p&gt;
  ///      * This transaction SHALL be deserialized and submitted for consensus
  ///      * with no further validation.&lt;br/&gt;
  ///      * Specifically, the transaction may violate basic limits and
  ///      * constraints such as size limits, minimum or maximum values,
  ///      * valid start time, fee calculations, etc...
  final List<int>? transactionBytes;

  const HederaUncheckedSubmitBody({
    this.transactionBytes,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.bytes(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transactionBytes,
      ];


HederaUncheckedSubmitBody copyWith(
{List<int>? transactionBytes,

}) {
    return HederaUncheckedSubmitBody(
transactionBytes: transactionBytes ?? this.transactionBytes,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transactionBytes': config.encodeBinary(transactionBytes),
    };
  }


  factory HederaUncheckedSubmitBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaUncheckedSubmitBody(
      transactionBytes: config.decodeBinary<List<int>?>(json.valueAs('transactionBytes', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaUncheckedSubmitBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaUncheckedSubmitBody(
      transactionBytes: decode.getBytes<List<int>?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoUncheckedSubmitBody;

}



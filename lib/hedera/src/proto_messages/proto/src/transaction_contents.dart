import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Transaction Contents
///  * The Signed Transaction message which forms the content of a transaction
///  * `signedTransactionBytes`. This message is the result of several changes
///  * to transaction message structure over time.
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
///  * A combination transaction bytes and a map of signatures.&lt;br/&gt;
///  * This message contains a serialized `TransactionBody` in a byte array
///  * and a `SignatureMap` that contains all of the signatures offered to
///  * authenticate the transaction.
///  *
///  * ### Block Stream Effects
///  * This content is recorded in the record stream exactly as received.
class HederaSignedTransaction extends HederaProtoMessage with Equality {
  /// *
  ///      * A byte array containing a serialized `TransactionBody`.
  ///      * &lt;p&gt;
  ///      * This content is what the signatures in `sigMap` MUST sign.
  final List<int>? bodyBytes;

  /// *
  ///      * A set of cryptographic signatures.
  ///      * &lt;p&gt;
  ///      * This set MUST contain all signatures required to authenticate
  ///      * and authorize the transaction.&lt;br/&gt;
  ///      * This set MAY contain additional signatures.
  final proto_basic_types.HederaSignatureMap? sigMap;

  /// *
  ///      * If false then the hash of this transaction is the SHA-384 hash of the
  ///      * serialization of this SignedTransaction message as it arrived on the wire.
  ///      * &lt;p&gt;
  ///      * If true then the hash of this transaction is the SHA-384 hash of the
  ///      * ascending field order serialization of the Transaction whose `bodyBytes`
  ///      * and sigMap fields are deserialized from the contents of this message.
  final bool? useSerializedTxMessageHashAlgorithm;

  const HederaSignedTransaction({
    this.bodyBytes,
    this.sigMap,
    this.useSerializedTxMessageHashAlgorithm,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    bodyBytes,
    sigMap,
    useSerializedTxMessageHashAlgorithm,
  ];

  HederaSignedTransaction copyWith({
    List<int>? bodyBytes,

    proto_basic_types.HederaSignatureMap? sigMap,

    bool? useSerializedTxMessageHashAlgorithm,
  }) {
    return HederaSignedTransaction(
      bodyBytes: bodyBytes ?? this.bodyBytes,
      sigMap: sigMap ?? this.sigMap,
      useSerializedTxMessageHashAlgorithm:
          useSerializedTxMessageHashAlgorithm ??
          this.useSerializedTxMessageHashAlgorithm,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'bodyBytes': config.encodeBinary(bodyBytes),
      'sigMap': config.encodeMessage(sigMap),
      'use_serialized_tx_message_hash_algorithm':
          useSerializedTxMessageHashAlgorithm,
    };
  }

  factory HederaSignedTransaction.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSignedTransaction(
      bodyBytes: config.decodeBinary<List<int>?>(
        json.valueAs('bodyBytes', normalizeKeyLookup: config.normalizeKeys),
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
      useSerializedTxMessageHashAlgorithm: json.valueAsBool<bool?>(
        'use_serialized_tx_message_hash_algorithm',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaSignedTransaction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignedTransaction(
      bodyBytes: decode.getBytes<List<int>?>(1),
      sigMap: decode.messageTo<proto_basic_types.HederaSignatureMap?>(
        2,
        (b) => proto_basic_types.HederaSignatureMap.deserialize(b),
      ),
      useSerializedTxMessageHashAlgorithm: decode.getBool<bool?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoSignedTransaction;
}

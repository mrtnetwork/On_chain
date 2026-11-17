import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Tss Encryption Key Transaction
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.services.auxiliary.tss"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body for sending the public TSS encryption key.
class HederaTssEncryptionKeyTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///    * The raw bytes of the public TSS encryption key of the node sending the transaction.
  ///    * &lt;p&gt;
  ///    * This value MUST be set.&lt;br/&gt;
  ///    * This value MUST NOT be empty.&lt;br/&gt;
  final List<int>? publicTssEncryptionKey;

  const HederaTssEncryptionKeyTransactionBody({this.publicTssEncryptionKey});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [publicTssEncryptionKey];

  HederaTssEncryptionKeyTransactionBody copyWith({
    List<int>? publicTssEncryptionKey,
  }) {
    return HederaTssEncryptionKeyTransactionBody(
      publicTssEncryptionKey:
          publicTssEncryptionKey ?? this.publicTssEncryptionKey,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'publicTssEncryptionKey': config.encodeBinary(publicTssEncryptionKey),
    };
  }

  factory HederaTssEncryptionKeyTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTssEncryptionKeyTransactionBody(
      publicTssEncryptionKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'publicTssEncryptionKey',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaTssEncryptionKeyTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTssEncryptionKeyTransactionBody(
      publicTssEncryptionKey: decode.getBytes<List<int>?>(1),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiServicesAuxiliaryTssTssEncryptionKeyTransactionBody;
}

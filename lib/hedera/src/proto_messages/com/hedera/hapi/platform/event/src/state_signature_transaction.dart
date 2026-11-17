import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # State Signature Transaction
///  * An signature of a state snapshot gossiped to other nodes.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119).
/// * Hedera Network Services Protobuf
///  *
///  * Copyright (C) 2018 - 2024 Hedera Hashgraph, LLC
///  *
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.platform.event"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An signature of a state snapshot gossiped to other nodes.
///  * Each node SHALL hash the root of the merkle tree of a state snapshot every
///  * round. Once this hash is calculated, it SHOULD be signed with the nodes
///  * private signing key. This signature, together with the hash SHOULD be added
///  * to an event as a StateSignatureTransaction.
class HederaStateSignatureTransaction extends HederaProtoMessage with Equality {
  /// *
  ///    * The round number corresponding to the round number of the state snapshot
  ///    * being signed.&lt;br/&gt;
  ///    * This number MUST be greater than 0.
  final BigInt? round;

  /// *
  ///    * The signature of state snapshot hash.&lt;br/&gt;
  ///    * This signature MUST be a RSA signature with a maximum length of 384 bytes.&lt;br/&gt;
  ///    * The signature algorithm used MUST be RSASSA-PKCS1-v1_5 with SHA-384.
  final List<int>? signature;

  /// *
  ///    * The hash of the state snapshot being signed.&lt;br/&gt;
  ///    * This hash MUST be a SHA-384 hash.
  final List<int>? hash;

  const HederaStateSignatureTransaction({
    this.round,
    this.signature,
    this.hash,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [round, signature, hash];

  HederaStateSignatureTransaction copyWith({
    BigInt? round,

    List<int>? signature,

    List<int>? hash,
  }) {
    return HederaStateSignatureTransaction(
      round: round ?? this.round,
      signature: signature ?? this.signature,
      hash: hash ?? this.hash,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'round': config.encodeBigint(round),
      'signature': config.encodeBinary(signature),
      'hash': config.encodeBinary(hash),
    };
  }

  factory HederaStateSignatureTransaction.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaStateSignatureTransaction(
      round: json.valueAsBigInt<BigInt?>(
        'round',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaStateSignatureTransaction.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStateSignatureTransaction(
      round: decode.getBigInt<BigInt?>(1),
      signature: decode.getBytes<List<int>?>(2),
      hash: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiPlatformEventStateSignatureTransaction;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Running Hashes
///  * The running hash values for the record stream, including current and
///  * three(3) previous values.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.blockrecords"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * The running hash of transaction records and the previous `3` running hashes.
///  *
///  * All hashes are 48 byte SHA384 hash values. If the running hashes do not
///  * exist yet (for example, at genesis) then each not-yet-available value SHALL
///  * be empty (zero-length) bytes.
class HederaRunningHashes extends HederaProtoMessage with Equality {
    /// *
  ///      * A running hash of all record stream items.
  final List<int>? runningHash;

    /// *
  ///      * The previous running hash of all record stream items.
  final List<int>? nMinus1RunningHash;

    /// *
  ///      * The previous, previous running hash of all record stream items.
  final List<int>? nMinus2RunningHash;

    /// *
  ///      * The previous, previous, previous running hash of all record stream items.
  final List<int>? nMinus3RunningHash;

  const HederaRunningHashes({
    this.runningHash,
    this.nMinus1RunningHash,
    this.nMinus2RunningHash,
    this.nMinus3RunningHash,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        runningHash,
        nMinus1RunningHash,
        nMinus2RunningHash,
        nMinus3RunningHash,
      ];


HederaRunningHashes copyWith(
{List<int>? runningHash,

List<int>? nMinus1RunningHash,

List<int>? nMinus2RunningHash,

List<int>? nMinus3RunningHash,

}) {
    return HederaRunningHashes(
runningHash: runningHash ?? this.runningHash,
nMinus1RunningHash: nMinus1RunningHash ?? this.nMinus1RunningHash,
nMinus2RunningHash: nMinus2RunningHash ?? this.nMinus2RunningHash,
nMinus3RunningHash: nMinus3RunningHash ?? this.nMinus3RunningHash,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'running_hash': config.encodeBinary(runningHash),
      'n_minus_1_running_hash': config.encodeBinary(nMinus1RunningHash),
      'n_minus_2_running_hash': config.encodeBinary(nMinus2RunningHash),
      'n_minus_3_running_hash': config.encodeBinary(nMinus3RunningHash),
    };
  }


  factory HederaRunningHashes.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRunningHashes(
      runningHash: config.decodeBinary<List<int>?>(json.valueAs('running_hash', normalizeKeyLookup: config.normalizeKeys)),
      nMinus1RunningHash: config.decodeBinary<List<int>?>(json.valueAs('n_minus_1_running_hash', normalizeKeyLookup: config.normalizeKeys)),
      nMinus2RunningHash: config.decodeBinary<List<int>?>(json.valueAs('n_minus_2_running_hash', normalizeKeyLookup: config.normalizeKeys)),
      nMinus3RunningHash: config.decodeBinary<List<int>?>(json.valueAs('n_minus_3_running_hash', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaRunningHashes.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRunningHashes(
      runningHash: decode.getBytes<List<int>?>(1),
      nMinus1RunningHash: decode.getBytes<List<int>?>(2),
      nMinus2RunningHash: decode.getBytes<List<int>?>(3),
      nMinus3RunningHash: decode.getBytes<List<int>?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoRunningHashes;

}



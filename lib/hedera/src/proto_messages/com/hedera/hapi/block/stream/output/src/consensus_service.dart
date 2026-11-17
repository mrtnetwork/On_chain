import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * A version of the topic running hash.
///  *
///  * The inputs to the topic running hash have changed over time.
///  * This is tracked in earlier record streams as an integer. For the
///  * block stream we chose to use an enumeration for both efficiency
///  * and clarity. Placing the most recent, and most common/highest
///  * volume, version as `0` reduces the serialized size of this message
///  * by not serializing that default value.
///  *
///  * &lt;hr style="margin: 0.2em 5em 0.2em 5em; height: 0.5em;
///  *     border-style: solid none solid none; border-width: 2px;"/&gt;
///  *
///  * The topic running hash is a 48-byte value that is the output
///  * of a hash digest with input data determined by the value of
///  * the `topic_running_hash_version` field.&lt;br/&gt;
///  * All new transactions SHALL use `topic_running_hash_version`
///  * `WITH_MESSAGE_DIGEST_AND_PAYER`.&lt;br/&gt;
enum HederaRunningHashVersion implements ProtoEnumVariant {
  /// *
  ///      * The most recent version.
  ///      * &lt;p&gt;
  ///      * This version SHALL include, in order
  ///      * &lt;ol&gt;
  ///      *  &lt;li&gt;The previous running hash of the topic (48 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_running_hash_version` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The payer account's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The payer account's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The payer account's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of seconds since the epoch when the
  ///      *      `ConsensusSubmitMessage` reached consensus (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of nanoseconds within the second when the
  ///      *      `ConsensusSubmitMessage` reached consensus (4 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_sequence_number` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The output of a SHA-384 digest of the message bytes from the
  ///      *      `ConsensusSubmitMessage` (48 bytes)&lt;/li&gt;
  ///      * &lt;/ol&gt;
  withMessageDigestAndPayer(0, 'WITH_MESSAGE_DIGEST_AND_PAYER'),

  /// *
  ///      * An earlier version.
  ///      * &lt;p&gt;
  ///      * This version SHALL include, in order
  ///      * &lt;ol&gt;
  ///      *  &lt;li&gt;The previous running hash of the topic (48 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_running_hash_version` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of seconds since the epoch when the
  ///      *      `ConsensusSubmitMessage` reached consensus (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of nanoseconds within the second when the
  ///      *      `ConsensusSubmitMessage` reached consensus (4 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_sequence_number` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The output of a SHA-384 digest of the message bytes from the
  ///      *      `ConsensusSubmitMessage` (48 bytes)&lt;/li&gt;
  ///      * &lt;/ol&gt;
  withMessageDigest(1, 'WITH_MESSAGE_DIGEST'),

  /// *
  ///      * The original version, used at genesis.
  ///      * &lt;p&gt;
  ///      * This version SHALL include, in order
  ///      * &lt;ol&gt;
  ///      *  &lt;li&gt;The previous running hash of the topic (48 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of seconds since the epoch when the
  ///      *      `ConsensusSubmitMessage` reached consensus (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of nanoseconds within the second when the
  ///      *      `ConsensusSubmitMessage` reached consensus (4 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_sequence_number` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The message bytes from the `ConsensusSubmitMessage`
  ///      *      (variable)&lt;/li&gt;
  ///      * &lt;/ol&gt;
  withFullMessage(2, 'WITH_FULL_MESSAGE');

  const HederaRunningHashVersion(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaRunningHashVersion fromValue(int? value) {
    value ??= 0;
    return HederaRunningHashVersion.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaRunningHashVersion found for the given value. $value",
                details: {
                  "name": "HederaRunningHashVersion",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaRunningHashVersion from(Object? value) {
    value ??= 0;
    return HederaRunningHashVersion.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaRunningHashVersion found for the given value. $value",
                details: {
                  "name": "HederaRunningHashVersion",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// *
///  * # Consensus Service
///  * Block stream messages that report the results of transactions handled
///  * by the `Consensus` service.
///  *
///  * ### Topic Running Hash Calculation
///  * Submitted messages include a topic running hash. This value has changed
///  * over time, with the known versions detailed in the `RunningHashVersion`
///  * enumeration. The running hash version SHALL NOT be transmitted in the
///  * Block Stream, however, as it is a fixed value that can only be changed
///  * with a new release of consensus node software following a HIP to update
///  * the specification, so repeating that fixed value in the block stream is
///  * wasteful and unnecessary.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.output"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Block Stream data for a `createTopic` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in the
///  * original transaction.
class HederaCreateTopicOutput extends HederaProtoMessage with Equality {
  const HederaCreateTopicOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaCreateTopicOutput copyWith() {
    return HederaCreateTopicOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaCreateTopicOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCreateTopicOutput();
  }

  factory HederaCreateTopicOutput.deserialize(List<int> bytes) {
    return HederaCreateTopicOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputCreateTopicOutput;
}

/// *
///  * Block Stream data for a `updateTopic` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in the
///  * original transaction.
class HederaUpdateTopicOutput extends HederaProtoMessage with Equality {
  const HederaUpdateTopicOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaUpdateTopicOutput copyWith() {
    return HederaUpdateTopicOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaUpdateTopicOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUpdateTopicOutput();
  }

  factory HederaUpdateTopicOutput.deserialize(List<int> bytes) {
    return HederaUpdateTopicOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputUpdateTopicOutput;
}

/// *
///  * Block Stream data for a `deleteTopic` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in the
///  * original transaction.
class HederaDeleteTopicOutput extends HederaProtoMessage with Equality {
  const HederaDeleteTopicOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaDeleteTopicOutput copyWith() {
    return HederaDeleteTopicOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaDeleteTopicOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaDeleteTopicOutput();
  }

  factory HederaDeleteTopicOutput.deserialize(List<int> bytes) {
    return HederaDeleteTopicOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputDeleteTopicOutput;
}

/// *
///  * Block Stream data for a `submitMessage` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in the
///  * original transaction.&lt;br/&gt;
///  * The actual topic running hash SHALL be present in a `StateChanges` block
///  * item, and is not duplicated here.
class HederaSubmitMessageOutput extends HederaProtoMessage with Equality {
  const HederaSubmitMessageOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaSubmitMessageOutput copyWith() {
    return HederaSubmitMessageOutput();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaSubmitMessageOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSubmitMessageOutput();
  }

  factory HederaSubmitMessageOutput.deserialize(List<int> bytes) {
    return HederaSubmitMessageOutput();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputSubmitMessageOutput;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;

/// *
///  * # Event Consensus Data
///  * A message that describes the consensus data for an event.
///  *
///  * The `EventConsensusData` contains two fields that are determined once an
///  * event reaches consensus, the `consensus_timestamp` and `consensus_order`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119).
/// * Hedera Network Services Protobuf
///  *
///  * Copyright (C) 2024 Hedera Hashgraph, LLC
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
///  * Event Consensus Data.&lt;br/&gt;
///  * This message records the critical values produced by consensus for an event.
class HederaEventConsensusData extends HederaProtoMessage with Equality {
  /// *
  ///      * A consensus timestamp.&lt;br/&gt;
  ///      * The network's consensus agreement on a timestamp for this event.
  ///      * &lt;p&gt;
  ///      * This timestamp MUST be strictly greater than the `consensus_timestamp` of
  ///      * the previous consensus event.&lt;br/&gt;
  ///      * This is a consensus value and MAY NOT match real-world "wall clock" time.
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

  /// *
  ///      * A consensus order sequence number.&lt;br/&gt;
  ///      * A non-negative sequence number that identifies an event's consensus order
  ///      * since genesis.
  ///      * &lt;p&gt;
  ///      * This SHALL be the unique for each consensus event.&lt;br/&gt;
  ///      * This SHALL always increase, and SHALL NOT decrease.&lt;br/&gt;
  ///      * This SHALL increment by one for each consensus event.
  final BigInt? consensusOrder;

  const HederaEventConsensusData({
    this.consensusTimestamp,
    this.consensusOrder,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.uint64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [consensusTimestamp, consensusOrder];

  HederaEventConsensusData copyWith({
    proto_timestamp.HederaTimestamp? consensusTimestamp,

    BigInt? consensusOrder,
  }) {
    return HederaEventConsensusData(
      consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
      consensusOrder: consensusOrder ?? this.consensusOrder,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'consensus_timestamp': config.encodeMessage(consensusTimestamp),
      'consensus_order': config.encodeBigint(consensusOrder),
    };
  }

  factory HederaEventConsensusData.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEventConsensusData(
      consensusTimestamp: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'consensus_timestamp',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      consensusOrder: json.valueAsBigInt<BigInt?>(
        'consensus_order',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEventConsensusData.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEventConsensusData(
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        1,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      consensusOrder: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiPlatformEventEventConsensusData;
}

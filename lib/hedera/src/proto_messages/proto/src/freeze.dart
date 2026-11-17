import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/freeze_type.dart"
    as proto_freeze_type;

/// *
///  * # Freeze
///  * Transaction body for a network "freeze" transaction.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.freeze"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body for all five freeze transactions.
///  *
///  * Combining five different transactions into a single message, this
///  * transaction body MUST support options to schedule a freeze, abort a
///  * scheduled freeze, prepare a software upgrade, prepare a telemetry
///  * upgrade, or initiate a software upgrade.
///  *
///  * For a scheduled freeze, at the scheduled time, according to
///  * network consensus time
///  *   - A freeze (`FREEZE_ONLY`) causes the network nodes to stop creating
///  *     events or accepting transactions, and enter a persistent
///  *     maintenance state.
///  *   - A freeze upgrade (`FREEZE_UPGRADE`) causes the network nodes to stop
///  *     creating events or accepting transactions, and upgrade the node software
///  *     from a previously prepared upgrade package. The network nodes then
///  *     restart and rejoin the network after upgrading.
///  *
///  * For other freeze types, immediately upon processing the freeze transaction
///  *   - A Freeze Abort (`FREEZE_ABORT`) cancels any pending scheduled freeze.
///  *   - A prepare upgrade (`PREPARE_UPGRADE`) begins to extract the contents of
///  *     the specified upgrade file to the local filesystem.
///  *   - A telemetry upgrade (`TELEMETRY_UPGRADE`) causes the network nodes to
///  *     extract a telemetry upgrade package to the local filesystem and signal
///  *     other software on the machine to upgrade, without impacting the node or
///  *     network processing.
///  *
///  * ### Block Stream Effects
///  * Unknown
class HederaFreezeTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///      * Rejected if set; replace with `start_time`.&lt;br/&gt;
  ///      * The start hour (in UTC time), a value between 0 and 23
  final int? startHour;

  /// *
  ///      * Rejected if set; replace with `start_time`.&lt;br/&gt;
  ///      * The start minute (in UTC time), a value between 0 and 59
  final int? startMin;

  /// *
  ///      * Rejected if set; end time is neither assigned nor guaranteed and depends
  ///      * on many uncontrolled factors.&lt;br/&gt;
  ///      * The end hour (in UTC time), a value between 0 and 23
  final int? endHour;

  /// *
  ///      * Rejected if set; end time is neither assigned nor guaranteed and depends
  ///      * on many uncontrolled factors.&lt;br/&gt;
  ///      * The end minute (in UTC time), a value between 0 and 59
  final int? endMin;

  /// *
  ///      * An upgrade file.
  ///      * &lt;p&gt;
  ///      * If set, the identifier of a file in network state.&lt;br/&gt;
  ///      * The contents of this file MUST be a `zip` file and this data
  ///      * SHALL be extracted to the node filesystem during a
  ///      * `PREPARE_UPGRADE` or `TELEMETRY_UPGRADE` freeze type.&lt;br/&gt;
  ///      * The `file_hash` field MUST match the SHA384 hash of the content
  ///      * of this file.&lt;br/&gt;
  ///      * The extracted data SHALL be used to perform a network software update
  ///      * if a `FREEZE_UPGRADE` freeze type is subsequently processed.
  final proto_basic_types.HederaFileID? updateFile;

  /// *
  ///      * A SHA384 hash of file content.&lt;br/&gt;
  ///      * This is a hash of the file identified by `update_file`.
  ///      * &lt;p&gt;
  ///      * This MUST be set if `update_file` is set, and MUST match the
  ///      * SHA384 hash of the contents of that file.
  final List<int>? fileHash;

  /// *
  ///      * A start time for the freeze.
  ///      * &lt;p&gt;
  ///      * If this field is REQUIRED for the specified `freeze_type`, then
  ///      * when the network consensus time reaches this instant&lt;ol&gt;
  ///      *   &lt;li&gt;The network SHALL stop accepting transactions.&lt;/li&gt;
  ///      *   &lt;li&gt;The network SHALL gossip a freeze state.&lt;/li&gt;
  ///      *   &lt;li&gt;The nodes SHALL, in coordinated order, disconnect and
  ///      *       shut down.&lt;/li&gt;
  ///      *   &lt;li&gt;The nodes SHALL halt or perform a software upgrade, depending
  ///      *       on `freeze_type`.&lt;/li&gt;
  ///      *   &lt;li&gt;If the `freeze_type` is `FREEZE_UPGRADE`, the nodes SHALL
  ///      *       restart and rejoin the network upon completion of the
  ///      *       software upgrade.&lt;/li&gt;
  ///      * &lt;/ol&gt;
  ///      * &lt;blockquote&gt;
  ///      * If the `freeze_type` is `TELEMETRY_UPGRADE`, the start time is required,
  ///      * but the network SHALL NOT stop, halt, or interrupt transaction
  ///      * processing. The required field is an historical anomaly and SHOULD
  ///      * change in a future release.&lt;/blockquote&gt;
  final proto_timestamp.HederaTimestamp? startTime;

  /// *
  ///      * The type of freeze.
  ///      * &lt;p&gt;
  ///      * This REQUIRED field effectively selects between five quite different
  ///      * transactions in the same transaction body. Depending on this value
  ///      * the service may schedule a freeze, prepare upgrades, perform upgrades,
  ///      * or even abort a previously scheduled freeze.
  final proto_freeze_type.HederaFreezeType? freezeType;

  const HederaFreezeTransactionBody({
    this.startHour,
    this.startMin,
    this.endHour,
    this.endMin,
    this.updateFile,
    this.fileHash,
    this.startTime,
    this.freezeType,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(
          1,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.int32(
          2,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.int32(
          3,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.int32(
          4,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.enumType(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    startHour,
    startMin,
    endHour,
    endMin,
    updateFile,
    fileHash,
    startTime,
    freezeType,
  ];

  HederaFreezeTransactionBody copyWith({
    int? startHour,

    int? startMin,

    int? endHour,

    int? endMin,

    proto_basic_types.HederaFileID? updateFile,

    List<int>? fileHash,

    proto_timestamp.HederaTimestamp? startTime,

    proto_freeze_type.HederaFreezeType? freezeType,
  }) {
    return HederaFreezeTransactionBody(
      startHour: startHour ?? this.startHour,
      startMin: startMin ?? this.startMin,
      endHour: endHour ?? this.endHour,
      endMin: endMin ?? this.endMin,
      updateFile: updateFile ?? this.updateFile,
      fileHash: fileHash ?? this.fileHash,
      startTime: startTime ?? this.startTime,
      freezeType: freezeType ?? this.freezeType,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'startHour': startHour,
      'startMin': startMin,
      'endHour': endHour,
      'endMin': endMin,
      'update_file': config.encodeMessage(updateFile),
      'file_hash': config.encodeBinary(fileHash),
      'start_time': config.encodeMessage(startTime),
      'freeze_type': config.encodeEnum(freezeType),
    };
  }

  factory HederaFreezeTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFreezeTransactionBody(
      startHour: json.valueAsInt<int?>(
        'startHour',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      startMin: json.valueAsInt<int?>(
        'startMin',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endHour: json.valueAsInt<int?>(
        'endHour',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endMin: json.valueAsInt<int?>(
        'endMin',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      updateFile: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'update_file',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileHash: config.decodeBinary<List<int>?>(
        json.valueAs('file_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      startTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'start_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      freezeType: json.valueTo<proto_freeze_type.HederaFreezeType?, Object?>(
        key: 'freeze_type',
        parse: (v) => proto_freeze_type.HederaFreezeType.from(v),
      ),
    );
  }

  factory HederaFreezeTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFreezeTransactionBody(
      startHour: decode.getInt<int?>(1),
      startMin: decode.getInt<int?>(2),
      endHour: decode.getInt<int?>(3),
      endMin: decode.getInt<int?>(4),
      updateFile: decode.messageTo<proto_basic_types.HederaFileID?>(
        5,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      fileHash: decode.getBytes<List<int>?>(6),
      startTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        7,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      freezeType: decode.getEnum<proto_freeze_type.HederaFreezeType?>(
        8,
        proto_freeze_type.HederaFreezeType.values,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoFreezeTransactionBody;
}

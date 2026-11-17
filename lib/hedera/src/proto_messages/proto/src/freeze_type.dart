import 'package:blockchain_utils/blockchain_utils.dart';

/// *
///  * # Freeze Type
///  * An enumeration to select the type of a network freeze.
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
///  * An enumeration of possible network freeze types.
///  *
///  * Each enumerated value SHALL be associated to a single network freeze
///  * scenario. Each freeze scenario defines the specific parameters
///  * REQUIRED for that freeze.
enum HederaFreezeType implements ProtoEnumVariant {
    /// *
  ///      * An invalid freeze type.
  ///      * &lt;p&gt;
  ///      * The first value in a protobuf enum is a default value. This default
  ///      * is RECOMMENDED to be an invalid value to aid in detecting unset fields.
  unknownFreezeType(0, 'UNKNOWN_FREEZE_TYPE'),
    /// *
  ///      * Freeze the network, and take no further action.
  ///      * &lt;p&gt;
  ///      * The `start_time` field is REQUIRED, MUST be strictly later than the
  ///      * consensus time when this transaction is handled, and SHOULD be between
  ///      * `300` and `3600` seconds after the transaction identifier
  ///      * `transactionValidStart` field.&lt;br/&gt;
  ///      * The fields `update_file` and `file_hash` SHALL be ignored.&lt;br/&gt;
  ///      * A `FREEZE_ONLY` transaction SHALL NOT perform any network
  ///      * changes or upgrades.&lt;br/&gt;
  ///      * After this freeze is processed manual intervention is REQUIRED
  ///      * to restart the network.
  freezeOnly(1, 'FREEZE_ONLY'),
    /// *
  ///      * This freeze type does not freeze the network, but begins
  ///      * "preparation" to upgrade the network.
  ///      * &lt;p&gt;
  ///      * The fields `update_file` and `file_hash` are REQUIRED
  ///      * and MUST be valid.&lt;br/&gt;
  ///      * The `start_time` field SHALL be ignored.&lt;br/&gt;
  ///      * A `PREPARE_UPGRADE` transaction SHALL NOT freeze the network or
  ///      * interfere with general transaction processing.&lt;br/&gt;
  ///      * If this freeze type is initiated after a `TELEMETRY_UPGRADE`, the
  ///      * prepared telemetry upgrade SHALL be reset and all telemetry upgrade
  ///      * artifacts in the filesystem SHALL be deleted.&lt;br/&gt;
  ///      * At some point after this freeze type completes (dependent on the size
  ///      * of the upgrade file), the network SHALL be prepared to complete
  ///      * a software upgrade of all nodes.
  prepareUpgrade(2, 'PREPARE_UPGRADE'),
    /// *
  ///      * Freeze the network to perform a software upgrade.
  ///      * &lt;p&gt;
  ///      * The `start_time` field is REQUIRED, MUST be strictly later than the
  ///      * consensus time when this transaction is handled, and SHOULD be between
  ///      * `300` and `3600` seconds after the transaction identifier
  ///      * `transactionValidStart` field.&lt;br/&gt;
  ///      * A software upgrade file MUST be prepared prior to this transaction.&lt;br/&gt;
  ///      * After this transaction completes, the network SHALL initiate an
  ///      * upgrade and restart of all nodes at the start time specified.
  freezeUpgrade(3, 'FREEZE_UPGRADE'),
    /// *
  ///      * Abort a pending network freeze operation.
  ///      * &lt;p&gt;
  ///      * All fields SHALL be ignored for this freeze type.&lt;br/&gt;
  ///      * This freeze type MAY be submitted after a `FREEZE_ONLY`,
  ///      * `FREEZE_UPGRADE`, or `TELEMETRY_UPGRADE` is initiated.&lt;br/&gt;
  ///      * This freeze type MUST be submitted and reach consensus
  ///      * before the `start_time` designated for the current pending
  ///      * freeze to be effective.&lt;br/&gt;
  ///      * After this freeze type is processed, the upgrade file hash
  ///      * and pending freeze start time stored in the network SHALL
  ///      * be reset to default (empty) values.
  freezeAbort(4, 'FREEZE_ABORT'),
    /// *
  ///      * Prepare an upgrade of auxiliary services and containers
  ///      * providing telemetry/metrics.
  ///      * &lt;p&gt;
  ///      * The `start_time` field is REQUIRED, MUST be strictly later than the
  ///      * consensus time when this transaction is handled, and SHOULD be between
  ///      * `300` and `3600` seconds after the transaction identifier
  ///      * `transactionValidStart` field.&lt;br/&gt;
  ///      * The `update_file` field is REQUIRED and MUST be valid.&lt;br/&gt;
  ///      * A `TELEMETRY_UPGRADE` transaction SHALL NOT freeze the network or
  ///      * interfere with general transaction processing.&lt;br/&gt;
  ///      * This freeze type MUST NOT be initiated between a `PREPARE_UPGRADE`
  ///      * and `FREEZE_UPGRADE`. If this freeze type is initiated after a
  ///      * `PREPARE_UPGRADE`, the prepared upgrade SHALL be reset and all software
  ///      * upgrade artifacts in the filesystem SHALL be deleted.&lt;br/&gt;
  ///      * At some point after this freeze type completes (dependent on the
  ///      * size of the upgrade file), the network SHALL automatically upgrade
  ///      * the telemetry/metrics services and containers as directed in
  ///      * the specified telemetry upgrade file.
  ///      * &lt;blockquote&gt; The condition that `start_time` is REQUIRED is an
  ///      * historical anomaly and SHOULD change in a future release.&lt;/blockquote&gt;
  telemetryUpgrade(5, 'TELEMETRY_UPGRADE');

  const HederaFreezeType(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaFreezeType fromValue(int? value) {
    value ??=0;
    return HederaFreezeType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaFreezeType found for the given value. $value", details: {"name": "HederaFreezeType", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaFreezeType from(Object? value) {
    value ??=0;
    return HederaFreezeType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaFreezeType found for the given value. $value", details: {"name": "HederaFreezeType", "value": value?.toString()})
    );
  }

}



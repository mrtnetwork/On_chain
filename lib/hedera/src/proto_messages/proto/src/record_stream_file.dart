import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/hash_object.dart"
    as proto_hash_object;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart"
    as proto_transaction;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_record.dart"
    as proto_transaction_record;

/// *
///  * The type of sidecar records contained in the sidecar record file
enum HederaSidecarType implements ProtoEnumVariant {
  sidecarTypeUnknown(0, 'SIDECAR_TYPE_UNKNOWN'),
  contractStateChange(1, 'CONTRACT_STATE_CHANGE'),
  contractAction(2, 'CONTRACT_ACTION'),
  contractBytecode(3, 'CONTRACT_BYTECODE');

  const HederaSidecarType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaSidecarType fromValue(int? value) {
    value ??= 0;
    return HederaSidecarType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaSidecarType found for the given value. $value",
                details: {
                  "name": "HederaSidecarType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaSidecarType from(Object? value) {
    value ??= 0;
    return HederaSidecarType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaSidecarType found for the given value. $value",
                details: {
                  "name": "HederaSidecarType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// -
///  * ‌
///  * Hedera Network Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2022 Hedera Hashgraph, LLC
///  * ​
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
///  * ‍
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.streams"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * RecordStreamFile is used to serialize all RecordStreamItems that are part of the
///  * same period into record stream files.
///  * This structure represents a block in Hedera (HIP-415).
class HederaRecordStreamFile extends HederaProtoMessage with Equality {
  /// *
  ///    * Version of HAPI that was used to serialize the file.
  final proto_basic_types.HederaSemanticVersion? hapiProtoVersion;

  /// *
  ///    * Running Hash of all RecordStreamItems before writing this file.
  final proto_hash_object.HederaHashObject? startObjectRunningHash;

  /// *
  ///    * List of all the record stream items from that period.
  final List<HederaRecordStreamItem> recordStreamItems;

  /// *
  ///    * Running Hash of all RecordStreamItems before closing this file.
  final proto_hash_object.HederaHashObject? endObjectRunningHash;

  /// *
  ///    * The block number associated with this period.
  final BigInt? blockNumber;

  /// *
  ///    * List of the hashes of all the sidecar record files created for the same period.
  ///    * Allows multiple sidecar files to be linked to this RecordStreamFile.
  final List<HederaSidecarMetadata> sidecars;

  const HederaRecordStreamFile({
    this.hapiProtoVersion,
    this.startObjectRunningHash,
    this.recordStreamItems = const [],
    this.endObjectRunningHash,
    this.blockNumber,
    this.sidecars = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    hapiProtoVersion,
    startObjectRunningHash,
    recordStreamItems,
    endObjectRunningHash,
    blockNumber,
    sidecars,
  ];

  HederaRecordStreamFile copyWith({
    proto_basic_types.HederaSemanticVersion? hapiProtoVersion,

    proto_hash_object.HederaHashObject? startObjectRunningHash,

    List<HederaRecordStreamItem>? recordStreamItems,

    proto_hash_object.HederaHashObject? endObjectRunningHash,

    BigInt? blockNumber,

    List<HederaSidecarMetadata>? sidecars,
  }) {
    return HederaRecordStreamFile(
      hapiProtoVersion: hapiProtoVersion ?? this.hapiProtoVersion,
      startObjectRunningHash:
          startObjectRunningHash ?? this.startObjectRunningHash,
      recordStreamItems: recordStreamItems ?? this.recordStreamItems,
      endObjectRunningHash: endObjectRunningHash ?? this.endObjectRunningHash,
      blockNumber: blockNumber ?? this.blockNumber,
      sidecars: sidecars ?? this.sidecars,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'hapi_proto_version': config.encodeMessage(hapiProtoVersion),
      'start_object_running_hash': config.encodeMessage(startObjectRunningHash),
      'record_stream_items':
          recordStreamItems.map((e) => config.encodeMessage(e)).toList(),
      'end_object_running_hash': config.encodeMessage(endObjectRunningHash),
      'block_number': config.encodeBigint(blockNumber),
      'sidecars': sidecars.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaRecordStreamFile.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRecordStreamFile(
      hapiProtoVersion: json
          .valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
            key: 'hapi_proto_version',
            parse:
                (v) => proto_basic_types.HederaSemanticVersion.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      startObjectRunningHash: json
          .valueTo<proto_hash_object.HederaHashObject?, Object>(
            key: 'start_object_running_hash',
            parse:
                (v) => proto_hash_object.HederaHashObject.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      recordStreamItems:
          (json.valueEnsureAsList<dynamic>(
                'record_stream_items',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaRecordStreamItem, Object>(
                  value: e,
                  parse:
                      (v) => HederaRecordStreamItem.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      endObjectRunningHash: json
          .valueTo<proto_hash_object.HederaHashObject?, Object>(
            key: 'end_object_running_hash',
            parse:
                (v) => proto_hash_object.HederaHashObject.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      blockNumber: json.valueAsBigInt<BigInt?>(
        'block_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sidecars:
          (json.valueEnsureAsList<dynamic>(
                'sidecars',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaSidecarMetadata, Object>(
                  value: e,
                  parse:
                      (v) => HederaSidecarMetadata.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaRecordStreamFile.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRecordStreamFile(
      hapiProtoVersion: decode
          .messageTo<proto_basic_types.HederaSemanticVersion?>(
            1,
            (b) => proto_basic_types.HederaSemanticVersion.deserialize(b),
          ),
      startObjectRunningHash: decode
          .messageTo<proto_hash_object.HederaHashObject?>(
            2,
            (b) => proto_hash_object.HederaHashObject.deserialize(b),
          ),
      recordStreamItems:
          decode
              .getListOfBytes(3)
              .map((b) => HederaRecordStreamItem.deserialize(b))
              .toList(),
      endObjectRunningHash: decode
          .messageTo<proto_hash_object.HederaHashObject?>(
            4,
            (b) => proto_hash_object.HederaHashObject.deserialize(b),
          ),
      blockNumber: decode.getBigInt<BigInt?>(5),
      sidecars:
          decode
              .getListOfBytes(6)
              .map((b) => HederaSidecarMetadata.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoRecordStreamFile;
}

/// *
///  * A RecordStreamItem consists of a Transaction and a TransactionRecord,
///  * which are already defined protobuf messages.
class HederaRecordStreamItem extends HederaProtoMessage with Equality {
  final proto_transaction.HederaTransaction? transaction;

  final proto_transaction_record.HederaTransactionRecord? record;

  const HederaRecordStreamItem({this.transaction, this.record});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [transaction, record];

  HederaRecordStreamItem copyWith({
    proto_transaction.HederaTransaction? transaction,

    proto_transaction_record.HederaTransactionRecord? record,
  }) {
    return HederaRecordStreamItem(
      transaction: transaction ?? this.transaction,
      record: record ?? this.record,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transaction': config.encodeMessage(transaction),
      'record': config.encodeMessage(record),
    };
  }

  factory HederaRecordStreamItem.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRecordStreamItem(
      transaction: json.valueTo<proto_transaction.HederaTransaction?, Object>(
        key: 'transaction',
        parse:
            (v) => proto_transaction.HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      record: json
          .valueTo<proto_transaction_record.HederaTransactionRecord?, Object>(
            key: 'record',
            parse:
                (v) =>
                    proto_transaction_record.HederaTransactionRecord.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaRecordStreamItem.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRecordStreamItem(
      transaction: decode.messageTo<proto_transaction.HederaTransaction?>(
        1,
        (b) => proto_transaction.HederaTransaction.deserialize(b),
      ),
      record: decode
          .messageTo<proto_transaction_record.HederaTransactionRecord?>(
            2,
            (b) =>
                proto_transaction_record.HederaTransactionRecord.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoRecordStreamItem;
}

/// *
///  * Information about a single sidecar file.
class HederaSidecarMetadata extends HederaProtoMessage with Equality {
  /// *
  ///    * The hash of the entire file.
  final proto_hash_object.HederaHashObject? hash;

  /// *
  ///    * The id of the sidecar record file
  final int? id;

  /// *
  ///    * The types of sidecar records that will be included in the file.
  final List<HederaSidecarType> types;

  const HederaSidecarMetadata({this.hash, this.id, this.types = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.enumType,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [hash, id, types];

  HederaSidecarMetadata copyWith({
    proto_hash_object.HederaHashObject? hash,

    int? id,

    List<HederaSidecarType>? types,
  }) {
    return HederaSidecarMetadata(
      hash: hash ?? this.hash,
      id: id ?? this.id,
      types: types ?? this.types,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'hash': config.encodeMessage(hash),
      'id': id,
      'types': types.map((e) => config.encodeEnum(e)).toList(),
    };
  }

  factory HederaSidecarMetadata.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSidecarMetadata(
      hash: json.valueTo<proto_hash_object.HederaHashObject?, Object>(
        key: 'hash',
        parse:
            (v) => proto_hash_object.HederaHashObject.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      id: json.valueAsInt<int?>('id', normalizeKeyLookup: config.normalizeKeys),
      types:
          (json.valueEnsureAsList<dynamic>(
                'types',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaSidecarType, Object>(
                  value: e,
                  parse: (v) => HederaSidecarType.from(v),
                ),
              )
              .toList(),
    );
  }

  factory HederaSidecarMetadata.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSidecarMetadata(
      hash: decode.messageTo<proto_hash_object.HederaHashObject?>(
        1,
        (b) => proto_hash_object.HederaHashObject.deserialize(b),
      ),
      id: decode.getInt<int?>(2),
      types: decode.getReapeatedEnum<HederaSidecarType>(
        3,
        HederaSidecarType.values,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoSidecarMetadata;
}

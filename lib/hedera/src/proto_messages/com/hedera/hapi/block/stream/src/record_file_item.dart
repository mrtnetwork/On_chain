import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/sidecar_file.dart"
    as proto_sidecar_file;

/// *
///  * # Record File Block
///  * This block carries the data from "record stream" and "sidecar"
///  * files that preceded the block stream. Record blocks are full blocks,
///  * not block items, but do not have a block header or block proof.
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A Block Item for record files.
///  *
///  * A `RecordFileItem` contains data produced before the innovation of the
///  * Block Stream, when data was stored in files and validated by individual
///  * signature files rather than a block proof.&lt;br/&gt;
///  * This item enables a single format, the Block Stream, to carry both
///  * historical and current data; eliminating the need to search two sources for
///  * block and block chain data.&lt;br/&gt;
///  * Any block containing this item requires special handling.
///  * - The block SHALL have a `BlockHeader`.
///  *    - Some fields in the `BlockHeader` may be interpreted differently, and
///  *      may depend on when the original record file was created.
///  * - The block SHALL NOT have a `BlockProof`.
///  * - The block SHALL end with an `AddressBookProof`, which is only used for
///  *   `RecordFileItem` blocks.
///  * - The block SHALL contain _exactly one_ `RecordFileItem`.
///  * - The block SHALL NOT contain any content item other than a `RecordFileItem`.
///  * - The content of the `RecordFileItem` MUST be validated using the
///  *   signature data and content provided herein according to the
///  *   process used for Record Files prior to the creation of Block Stream.
///  *    - This block item only replaces the requirement to read several
///  *      individual files from cloud storage services.
///  * - The address book relevant to a particular record file SHALL be available
///  *   separately as an `AddressBookProof` item.
class HederaRecordFileItem extends HederaProtoMessage with Equality {
  /// *
  ///      * The consensus time the record file was produced for.&lt;br/&gt;
  ///      * This comes from the record file name.
  final proto_timestamp.HederaTimestamp? creationTime;

  /// *
  ///      * The contents of a record file.&lt;br/&gt;
  ///      * The first 4 bytes are a 32bit int little endian version number.
  ///      * The versions that existed are 2,3,5 and 6.
  final List<int>? recordFileContents;

  /// *
  ///      * The contents of sidecar files for this block.&lt;br/&gt;
  ///      * Each block can have zero or more sidecar files.
  final List<proto_sidecar_file.HederaSidecarFile> sidecarFileContents;

  /// *
  ///      * A collection of RSA signatures from consensus nodes.&lt;br/&gt;
  ///      * These signatures validate the hash of the record_file_contents field.
  final List<HederaRecordFileSignature> recordFileSignatures;

  const HederaRecordFileItem({
    this.creationTime,
    this.recordFileContents,
    this.sidecarFileContents = const [],
    this.recordFileSignatures = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    creationTime,
    recordFileContents,
    sidecarFileContents,
    recordFileSignatures,
  ];

  HederaRecordFileItem copyWith({
    proto_timestamp.HederaTimestamp? creationTime,

    List<int>? recordFileContents,

    List<proto_sidecar_file.HederaSidecarFile>? sidecarFileContents,

    List<HederaRecordFileSignature>? recordFileSignatures,
  }) {
    return HederaRecordFileItem(
      creationTime: creationTime ?? this.creationTime,
      recordFileContents: recordFileContents ?? this.recordFileContents,
      sidecarFileContents: sidecarFileContents ?? this.sidecarFileContents,
      recordFileSignatures: recordFileSignatures ?? this.recordFileSignatures,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'creation_time': config.encodeMessage(creationTime),
      'record_file_contents': config.encodeBinary(recordFileContents),
      'sidecar_file_contents':
          sidecarFileContents.map((e) => config.encodeMessage(e)).toList(),
      'record_file_signatures':
          recordFileSignatures.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaRecordFileItem.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRecordFileItem(
      creationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'creation_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      recordFileContents: config.decodeBinary<List<int>?>(
        json.valueAs(
          'record_file_contents',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      sidecarFileContents:
          (json.valueEnsureAsList<dynamic>(
                'sidecar_file_contents',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_sidecar_file.HederaSidecarFile,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_sidecar_file.HederaSidecarFile.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      recordFileSignatures:
          (json.valueEnsureAsList<dynamic>(
                'record_file_signatures',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaRecordFileSignature, Object>(
                  value: e,
                  parse:
                      (v) => HederaRecordFileSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaRecordFileItem.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRecordFileItem(
      creationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        1,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      recordFileContents: decode.getBytes<List<int>?>(2),
      sidecarFileContents:
          decode
              .getListOfBytes(3)
              .map((b) => proto_sidecar_file.HederaSidecarFile.deserialize(b))
              .toList(),
      recordFileSignatures:
          decode
              .getListOfBytes(4)
              .map((b) => HederaRecordFileSignature.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamRecordFileItem;
}

/// *
///  * A signature by a node on the SHA384 hash of the record file.
class HederaRecordFileSignature extends HederaProtoMessage with Equality {
  /// *
  ///      * A single RSA signature.&lt;br/&gt;
  ///      * This is the RSA signature of the node on the SHA384 hash of
  ///      * the record file
  final List<int>? signaturesBytes;

  /// *
  ///      * A unique node identifier.&lt;br/&gt;
  ///      * This is the node id of the consensus node that created this signature.
  final int? nodeId;

  const HederaRecordFileSignature({this.signaturesBytes, this.nodeId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [signaturesBytes, nodeId];

  HederaRecordFileSignature copyWith({
    List<int>? signaturesBytes,

    int? nodeId,
  }) {
    return HederaRecordFileSignature(
      signaturesBytes: signaturesBytes ?? this.signaturesBytes,
      nodeId: nodeId ?? this.nodeId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'signatures_bytes': config.encodeBinary(signaturesBytes),
      'node_id': nodeId,
    };
  }

  factory HederaRecordFileSignature.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRecordFileSignature(
      signaturesBytes: config.decodeBinary<List<int>?>(
        json.valueAs(
          'signatures_bytes',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      nodeId: json.valueAsInt<int?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaRecordFileSignature.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRecordFileSignature(
      signaturesBytes: decode.getBytes<List<int>?>(1),
      nodeId: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamRecordFileSignature;
}

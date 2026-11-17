import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;

/// *
///  * # System Delete
///  * A system transaction to remove a file from the Hedera File
///  * Service (HFS).&lt;br/&gt;
///  * This transaction is a privileged operation restricted to "system"
///  * accounts.
///  *
///  * &gt; Note
///  * &gt;&gt; System delete is defined here for a smart contract (to delete
///  * &gt;&gt; the bytecode), but was never implemented.
///  * &gt;
///  * &gt;&gt; Currently, system delete and system undelete specifying a smart
///  * &gt;&gt; contract identifier SHALL return `INVALID_FILE_ID`
///  * &gt;&gt; or `MISSING_ENTITY_ID`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.file"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Delete a file or contract bytecode as an administrative transaction.
///  *
///  * &gt; Note
///  * &gt;&gt; A system delete/undelete for a `contractID` is not supported and
///  * &gt;&gt; SHALL return `INVALID_FILE_ID` or `MISSING_ENTITY_ID`.
///  *
///  * This transaction MAY be reversed by the `systemUndelete` transaction.
///  * A file deleted via `fileDelete`, however SHALL be irrecoverable.&lt;br/&gt;
///  * This transaction MUST specify an expiration timestamp (with seconds
///  * precision). The file SHALL be permanently removed from state when
///  * network consensus time exceeds the specified expiration time.&lt;br/&gt;
///  * This transaction MUST be signed by an Hedera administrative ("system")
///  * account.
///  *
///  * ### What is a "system" file
///  * A "system" file is any file with a file number less than or equal to the
///  * current configuration value for `ledger.numReservedSystemEntities`,
///  * typically `750`.
///  *
///  * ### Block Stream Effects
///  * None
class HederaSystemDeleteTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///          * A file identifier.
  ///          * &lt;p&gt;
  ///          * The identified file MUST exist in the HFS.&lt;br/&gt;
  ///          * The identified file MUST NOT be deleted.&lt;br/&gt;
  ///          * The identified file MUST NOT be a "system" file.&lt;br/&gt;
  ///          * This field is REQUIRED.
  final proto_basic_types.HederaFileID? fileID;

    /// *
  ///          * A contract identifier.
  ///          * &lt;p&gt;
  ///          * The identified contract MUST exist in network state.&lt;br/&gt;
  ///          * The identified contract bytecode MUST NOT be deleted.&lt;br/&gt;
  ///          * &lt;p&gt;
  ///          * This option is _unsupported_.
  final proto_basic_types.HederaContractID? contractID;

    /// *
  ///      * A timestamp indicating when the file will be removed from state.
  ///      * &lt;p&gt;
  ///      * This value SHALL be expressed in seconds since the `epoch`. The `epoch`
  ///      * SHALL be the UNIX epoch with 0 at `1970-01-01T00:00:00.000Z`.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final proto_timestamp.HederaTimestampSeconds? expirationTime;

  const HederaSystemDeleteTransactionBody({
    this.fileID,
    this.contractID,
    this.expirationTime,
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
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fileID,
        contractID,
        expirationTime,
      ];


HederaSystemDeleteTransactionBody copyWith(
{proto_basic_types.HederaFileID? fileID,

proto_basic_types.HederaContractID? contractID,

proto_timestamp.HederaTimestampSeconds? expirationTime,

}) {
    return HederaSystemDeleteTransactionBody(
fileID: fileID ?? this.fileID,
contractID: contractID ?? this.contractID,
expirationTime: expirationTime ?? this.expirationTime,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fileID': config.encodeMessage(fileID),
      'contractID': config.encodeMessage(contractID),
      'expirationTime': config.encodeMessage(expirationTime),
    };
  }


  factory HederaSystemDeleteTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSystemDeleteTransactionBody(
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse: (v) => proto_basic_types.HederaFileID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestampSeconds?, Object>(
        key: 'expirationTime',
        parse: (v) => proto_timestamp.HederaTimestampSeconds.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaSystemDeleteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSystemDeleteTransactionBody(
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(1, (b) => proto_basic_types.HederaFileID.deserialize(b)),
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(2, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestampSeconds?>(3, (b) => proto_timestamp.HederaTimestampSeconds.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSystemDeleteTransactionBody;

}



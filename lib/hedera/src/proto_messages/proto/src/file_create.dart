import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # File Create
///  * Messages to create a new file entry.
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
///  * Create a new file.
///  *
///  * If successful, the new file SHALL contain the (possibly empty) content
///  * provided in the `contents` field.&lt;br/&gt;
///  * When the current consensus time exceeds the `expirationTime` value, the
///  * network SHALL expire the file, and MAY archive the state entry.
///  *
///  * #### Signature Requirements
///  * The HFS manages file authorization in a manner that can be confusing.
///  * The core element of file authorization is the `keys` field,
///  * which is a `KeyList`; a list of individual `Key` messages, each of which
///  * may represent a simple or complex key.&lt;br/&gt;
///  * The file service transactions treat this list differently.&lt;br/&gt;
///  * A `fileCreate`, `fileAppend`, or `fileUpdate` MUST have a valid signature
///  * from _each_ key in the list.&lt;br/&gt;
///  * A `fileDelete` MUST have a valid signature from _at least one_ key in
///  * the list. This is different, and allows a file "owned" by many entities
///  * to be deleted by any one of those entities. A deleted file cannot be
///  * restored, so it is important to consider this when assigning keys for
///  * a file.&lt;br/&gt;
///  * If any of the keys in a `KeyList` are complex, the full requirements of
///  * each complex key must be met to count as a "valid signature" for that key.
///  * A complex key structure (i.e. a `ThresholdKey`, or `KeyList`, possibly
///  * including additional `ThresholdKey` or `KeyList` descendants) may be
///  * assigned as the sole entry in a file `keys` field to ensure all transactions
///  * have the same signature requirements.
///  *
///  * If the `keys` field is an empty `KeyList`, then the file SHALL be immutable
///  * and the only transaction permitted to modify that file SHALL be a
///  * `fileUpdate` transaction with _only_ the `expirationTime` set.
///  *
///  * #### Shard and Realm
///  * The current API ignores shardID and realmID. All files are created in
///  * shard 0 and realm 0. Future versions of the API may support multiple
///  * realms and multiple shards.
///  *
///  * ### Block Stream Effects
///  * After the file is created, the FileID for it SHALL be returned in the
///  * transaction receipt, and SHALL be recorded in the transaction record.
class HederaFileCreateTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * An expiration timestamp.
  ///      * &lt;p&gt;
  ///      * When the network consensus time exceeds this value, the network
  ///      * SHALL expire the file.
  final proto_timestamp.HederaTimestamp? expirationTime;

    /// *
  ///      * A list of keys that represent file "owners".
  ///      * &lt;p&gt;
  ///      * Every `Key` in this list MUST sign this `fileCreate` transaction, as
  ///      * well as any `fileUpdate` or `fileAppend` that modifies this file.&lt;br/&gt;
  ///      * At least one `Key` in this list MUST sign any `fileDelete` transaction
  ///      * to delete this file.&lt;br/&gt;
  ///      * If this `KeyList` is empty, the file SHALL be created immutable and the
  ///      * only field that may be changed subsequently is the `expirationTime`.
  ///      * An immutable file cannot be deleted except with a `systemDelete`
  ///      * transaction, or by expiration.
  final proto_basic_types.HederaKeyList? keys;

    /// *
  ///      * A byte array of file content.
  ///      * &lt;p&gt;
  ///      * The file SHALL be created with initial content equal to this field.
  final List<int>? contents;

    /// *
  ///      * A shard in which this file is created
  final proto_basic_types.HederaShardID? shardID;

    /// *
  ///      * A realm in which this file is created.
  ///      * &lt;p&gt;
  ///      * The shard number for this realm MUST match the value in `shardID`.&lt;br/&gt;
  ///      * Currently, this MUST be `0` for both fields.&lt;br/&gt;
  ///      * If the desired realm is `0.0`, this SHOULD NOT be set.
  final proto_basic_types.HederaRealmID? realmID;

    /// *
  ///      * The "create realm" was never enabled, and
  ///      * should not be possible on file creation.&lt;br/&gt;
  ///      * An admin key for a new realm, if one is created.
  ///      * Added deprecated tag 2024-05.
  final proto_basic_types.HederaKey? newRealmAdminKey;

    /// *
  ///      * A short description of this file.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  const HederaFileCreateTransactionBody({
    this.expirationTime,
    this.keys,
    this.contents,
    this.shardID,
    this.realmID,
    this.newRealmAdminKey,
    this.memo,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.string(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        expirationTime,
        keys,
        contents,
        shardID,
        realmID,
        newRealmAdminKey,
        memo,
      ];


HederaFileCreateTransactionBody copyWith(
{proto_timestamp.HederaTimestamp? expirationTime,

proto_basic_types.HederaKeyList? keys,

List<int>? contents,

proto_basic_types.HederaShardID? shardID,

proto_basic_types.HederaRealmID? realmID,

proto_basic_types.HederaKey? newRealmAdminKey,

String? memo,

}) {
    return HederaFileCreateTransactionBody(
expirationTime: expirationTime ?? this.expirationTime,
keys: keys ?? this.keys,
contents: contents ?? this.contents,
shardID: shardID ?? this.shardID,
realmID: realmID ?? this.realmID,
newRealmAdminKey: newRealmAdminKey ?? this.newRealmAdminKey,
memo: memo ?? this.memo,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'expirationTime': config.encodeMessage(expirationTime),
      'keys': config.encodeMessage(keys),
      'contents': config.encodeBinary(contents),
      'shardID': config.encodeMessage(shardID),
      'realmID': config.encodeMessage(realmID),
      'newRealmAdminKey': config.encodeMessage(newRealmAdminKey),
      'memo': memo,
    };
  }


  factory HederaFileCreateTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFileCreateTransactionBody(
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expirationTime',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      keys: json.valueTo<proto_basic_types.HederaKeyList?, Object>(
        key: 'keys',
        parse: (v) => proto_basic_types.HederaKeyList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contents: config.decodeBinary<List<int>?>(json.valueAs('contents', normalizeKeyLookup: config.normalizeKeys)),
      shardID: json.valueTo<proto_basic_types.HederaShardID?, Object>(
        key: 'shardID',
        parse: (v) => proto_basic_types.HederaShardID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      realmID: json.valueTo<proto_basic_types.HederaRealmID?, Object>(
        key: 'realmID',
        parse: (v) => proto_basic_types.HederaRealmID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      newRealmAdminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'newRealmAdminKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      memo: json.valueAsString<String?>('memo', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaFileCreateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileCreateTransactionBody(
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(2, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      keys: decode.messageTo<proto_basic_types.HederaKeyList?>(3, (b) => proto_basic_types.HederaKeyList.deserialize(b)),
      contents: decode.getBytes<List<int>?>(4),
      shardID: decode.messageTo<proto_basic_types.HederaShardID?>(5, (b) => proto_basic_types.HederaShardID.deserialize(b)),
      realmID: decode.messageTo<proto_basic_types.HederaRealmID?>(6, (b) => proto_basic_types.HederaRealmID.deserialize(b)),
      newRealmAdminKey: decode.messageTo<proto_basic_types.HederaKey?>(7, (b) => proto_basic_types.HederaKey.deserialize(b)),
      memo: decode.getString<String?>(8),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFileCreateTransactionBody;

}



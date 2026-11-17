import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_add_live_hash.dart"
    as proto_crypto_add_live_hash;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get By Key
///  * An obsolete query to obtain a list of entities that refer to
///  * a given Key object.&lt;br/&gt;
///  * Returned entities may be accounts, files, smart contracts, and/or
///  * live hash entries.
///  *
///  * &gt; Important
///  * &gt;&gt; This query is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any query of this type that is submitted SHALL fail with a `PRE_CHECK`
///  * &gt;&gt; result of `NOT_SUPPORTED`.
///  *
///  * &gt; Implementation Note
///  * &gt;&gt; This query is not defined for any service, and while it is implemented
///  * &gt;&gt; in the "Network Admin" service, it may be unnecessary to do so.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Query all accounts, claims, files, and smart contract instances whose
///  * associated keys include the given Key.
///  *
///  * &gt; This query is no longer supported.
class HederaGetByKeyQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaGetByKeyResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * The key to search for. It MUST NOT contain a contractID nor
  ///      * a ThresholdKey.
  final proto_basic_types.HederaKey? key;

  const HederaGetByKeyQuery({this.header, this.key});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, key];

  @override
  HederaGetByKeyQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaKey? key,
  }) {
    return HederaGetByKeyQuery(
      header: header ?? this.header,
      key: key ?? this.key,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(getByKey: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'key': config.encodeMessage(key),
    };
  }

  factory HederaGetByKeyQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGetByKeyQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      key: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaGetByKeyQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGetByKeyQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      key: decode.messageTo<proto_basic_types.HederaKey?>(
        2,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGetByKeyQuery;
}

/// *
///  * The ID for a single entity (account, livehash, file, or smart contract)
///  *
///  * &gt; The query that defines this message is no longer supported.
class HederaEntityID extends HederaProtoMessage with Equality {
  /// *
  ///          * The Account ID for the cryptocurrency account
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///          * A uniquely identifying livehash of an account
  final proto_crypto_add_live_hash.HederaLiveHash? liveHash;

  /// *
  ///          * The file ID of the file
  final proto_basic_types.HederaFileID? fileID;

  /// *
  ///          * The smart contract ID that identifies instance
  final proto_basic_types.HederaContractID? contractID;

  const HederaEntityID({
    this.accountID,
    this.liveHash,
    this.fileID,
    this.contractID,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [accountID, liveHash, fileID, contractID];

  HederaEntityID copyWith({
    proto_basic_types.HederaAccountID? accountID,

    proto_crypto_add_live_hash.HederaLiveHash? liveHash,

    proto_basic_types.HederaFileID? fileID,

    proto_basic_types.HederaContractID? contractID,
  }) {
    return HederaEntityID(
      accountID: accountID ?? this.accountID,
      liveHash: liveHash ?? this.liveHash,
      fileID: fileID ?? this.fileID,
      contractID: contractID ?? this.contractID,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'accountID': config.encodeMessage(accountID),
      'liveHash': config.encodeMessage(liveHash),
      'fileID': config.encodeMessage(fileID),
      'contractID': config.encodeMessage(contractID),
    };
  }

  factory HederaEntityID.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEntityID(
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      liveHash: json
          .valueTo<proto_crypto_add_live_hash.HederaLiveHash?, Object>(
            key: 'liveHash',
            parse:
                (v) => proto_crypto_add_live_hash.HederaLiveHash.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEntityID.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEntityID(
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      liveHash: decode.messageTo<proto_crypto_add_live_hash.HederaLiveHash?>(
        2,
        (b) => proto_crypto_add_live_hash.HederaLiveHash.deserialize(b),
      ),
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        3,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        4,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoEntityID;
}

/// *
///  * Response when the client sends the node GetByKeyQuery
///  *
///  * &gt; This query is no longer supported.
class HederaGetByKeyResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The list of entities that include this public key in their
  ///      * associated Key list
  final List<HederaEntityID> entities;

  const HederaGetByKeyResponse({this.header, this.entities = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, entities];

  HederaGetByKeyResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    List<HederaEntityID>? entities,
  }) {
    return HederaGetByKeyResponse(
      header: header ?? this.header,
      entities: entities ?? this.entities,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'entities': entities.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaGetByKeyResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGetByKeyResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      entities:
          (json.valueEnsureAsList<dynamic>(
                'entities',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaEntityID, Object>(
                  value: e,
                  parse:
                      (v) => HederaEntityID.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaGetByKeyResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGetByKeyResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      entities:
          decode
              .getListOfBytes(2)
              .map((b) => HederaEntityID.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGetByKeyResponse;
}

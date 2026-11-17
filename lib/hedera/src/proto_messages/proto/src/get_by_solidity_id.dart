import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get By Solidity
///  * A standard query to obtain account and contract identifiers for a smart
///  * contract, given the Solidity identifier for that contract.
///  *
///  * &gt; Important
///  * &gt;&gt; This query is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any query of this type that is submitted SHALL fail with a `PRE_CHECK`
///  * &gt;&gt; result of `NOT_SUPPORTED`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Query to read Contract, Account, and File identifiers for a smart
///  * contract given a Solidity identifier.
class HederaGetBySolidityIDQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaGetBySolidityIDResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A contract ID in the format used by Solidity.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  final String? solidityID;

  const HederaGetBySolidityIDQuery({this.header, this.solidityID});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.string(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, solidityID];

  @override
  HederaGetBySolidityIDQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    String? solidityID,
  }) {
    return HederaGetBySolidityIDQuery(
      header: header ?? this.header,
      solidityID: solidityID ?? this.solidityID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(getBySolidityID: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'header': config.encodeMessage(header), 'solidityID': solidityID};
  }

  factory HederaGetBySolidityIDQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGetBySolidityIDQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      solidityID: json.valueAsString<String?>(
        'solidityID',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaGetBySolidityIDQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGetBySolidityIDQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      solidityID: decode.getString<String?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGetBySolidityIDQuery;
}

/// *
///  * Response to a getBySolidityId query.
///  *
///  * This message returns the account, contract, and file identifiers for
///  * a smart contract.
class HederaGetBySolidityIDResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify an account that backs the requested smart contract.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * A file identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify a file, the contents of which are the EVM
  ///      * bytecode for the requested smart contract.
  final proto_basic_types.HederaFileID? fileID;

  /// *
  ///      * A contract identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the requested smart contract.
  final proto_basic_types.HederaContractID? contractID;

  const HederaGetBySolidityIDResponse({
    this.header,
    this.accountID,
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
  List<Object?> get protoValues => [header, accountID, fileID, contractID];

  HederaGetBySolidityIDResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_basic_types.HederaAccountID? accountID,

    proto_basic_types.HederaFileID? fileID,

    proto_basic_types.HederaContractID? contractID,
  }) {
    return HederaGetBySolidityIDResponse(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
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
      'header': config.encodeMessage(header),
      'accountID': config.encodeMessage(accountID),
      'fileID': config.encodeMessage(fileID),
      'contractID': config.encodeMessage(contractID),
    };
  }

  factory HederaGetBySolidityIDResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGetBySolidityIDResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
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

  factory HederaGetBySolidityIDResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGetBySolidityIDResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
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
      DefaultHederaProtoTypeUrl.protoGetBySolidityIDResponse;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Contract Bytecode
///  * A standard query to read the current bytecode for a smart contract.
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
///  * A transaction body to request the current bytecode for a smart contract.
class HederaContractGetBytecodeQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaContractGetBytecodeResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A smart contract ID.
  ///      * &lt;p&gt;
  ///      * The network SHALL return bytecode for this smart contract, if successful.
  final proto_basic_types.HederaContractID? contractID;

  const HederaContractGetBytecodeQuery({this.header, this.contractID});

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
  List<Object?> get protoValues => [header, contractID];

  @override
  HederaContractGetBytecodeQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaContractID? contractID,
  }) {
    return HederaContractGetBytecodeQuery(
      header: header ?? this.header,
      contractID: contractID ?? this.contractID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(contractGetBytecode: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'contractID': config.encodeMessage(contractID),
    };
  }

  factory HederaContractGetBytecodeQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractGetBytecodeQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
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

  factory HederaContractGetBytecodeQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractGetBytecodeQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        2,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractGetBytecodeQuery;
}

/// *
///  * Information returned in response to a "get bytecode" query for a
///  * smart contract.
class HederaContractGetBytecodeResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The current bytecode of the requested smart contract.
  final List<int>? bytecode;

  const HederaContractGetBytecodeResponse({this.header, this.bytecode});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(6)],
    );
  }

  @override
  List<Object?> get protoValues => [header, bytecode];

  HederaContractGetBytecodeResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    List<int>? bytecode,
  }) {
    return HederaContractGetBytecodeResponse(
      header: header ?? this.header,
      bytecode: bytecode ?? this.bytecode,
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
      'bytecode': config.encodeBinary(bytecode),
    };
  }

  factory HederaContractGetBytecodeResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractGetBytecodeResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bytecode: config.decodeBinary<List<int>?>(
        json.valueAs('bytecode', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaContractGetBytecodeResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractGetBytecodeResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      bytecode: decode.getBytes<List<int>?>(6),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractGetBytecodeResponse;
}

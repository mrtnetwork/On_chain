import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// -
///  * ‌
///  * Hedera Mirror Node
///  * ​
///  * Copyright (C) 2019-2022 Hedera Hashgraph, LLC
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
/// Required for the reactor-grpc generator to work correctly
/// *
///  * Request object to query an address book for its list of nodes
class HederaAddressBookQuery extends HederaProtoMessage with Equality {
    /// *
  ///      * The ID of the address book file on the network. Can be either 0.0.101 or 0.0.102.
  final proto_basic_types.HederaFileID? fileId;

    /// *
  ///      * The maximum number of node addresses to receive before stopping. If not set or set to zero it will return all node addresses in the database.
  final int? limit;

  const HederaAddressBookQuery({
    this.fileId,
    this.limit,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int32(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fileId,
        limit,
      ];


HederaAddressBookQuery copyWith(
{proto_basic_types.HederaFileID? fileId,

int? limit,

}) {
    return HederaAddressBookQuery(
fileId: fileId ?? this.fileId,
limit: limit ?? this.limit,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'file_id': config.encodeMessage(fileId),
      'limit': limit,
    };
  }


  factory HederaAddressBookQuery.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAddressBookQuery(
      fileId: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'file_id',
        parse: (v) => proto_basic_types.HederaFileID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      limit: json.valueAsInt<int?>('limit', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaAddressBookQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAddressBookQuery(
      fileId: decode.messageTo<proto_basic_types.HederaFileID?>(1, (b) => proto_basic_types.HederaFileID.deserialize(b)),
      limit: decode.getInt<int?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaMirrorApiProtoAddressBookQuery;

}


class HederaServiceNetworkServiceGetNodes extends HederaProtoMessage with Equality, IHederaServiceMessage<proto_basic_types.HederaNodeAddress> {
    /// * Query for an address book and return its nodes. The nodes are returned in ascending order by node ID. The
  ///      * response is not guaranteed to be a byte-for-byte equivalent to the NodeAddress in the Hedera file on
  ///      * the network since it is reconstructed from a normalized database table.
  final HederaAddressBookQuery? getNodes;

  const HederaServiceNetworkServiceGetNodes({
    this.getNodes,
  });

HederaServiceNetworkServiceGetNodes copyWith(
{HederaAddressBookQuery? getNodes,

}) {
    return HederaServiceNetworkServiceGetNodes(
getNodes: getNodes ?? this.getNodes,
    );
  }
  @override
  ProtoMessageConfig protoConfig() =>getNodes?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNodes?.protoValues??[];
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'getNodes': config.encodeMessage(getNodes),
    };
  }


  factory HederaServiceNetworkServiceGetNodes.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServiceNetworkServiceGetNodes(
      getNodes: json.valueTo<HederaAddressBookQuery?, Object>(
        key: 'getNodes',
        parse: (v) => HederaAddressBookQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaMirrorApiProtoServiceNetworkServiceGetNodes;
  @override
  proto_basic_types.HederaNodeAddress onServiceResponse(List<int> bytes) {
    return proto_basic_types.HederaNodeAddress.deserialize(bytes);
  }

}



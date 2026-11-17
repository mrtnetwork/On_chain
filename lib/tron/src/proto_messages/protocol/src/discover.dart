import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

/// Specify the name of the package that generated the Java file
/// Specify the class name of the generated Java file
class TronEndpoint extends TronProtoMessage {
  final List<int>? address;

  final int? port;

  final List<int>? nodeId;

  final List<int>? addressIpv6;

  const TronEndpoint({this.address, this.port, this.nodeId, this.addressIpv6});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [address, port, nodeId, addressIpv6];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'address': config.encodeBinary(address),
      'port': port,
      'nodeId': config.encodeBinary(nodeId),
      'addressIpv6': config.encodeBinary(addressIpv6),
    }.notNullValue;
  }

  factory TronEndpoint.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronEndpoint(
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
      port: json.valueAsInt<int?>(
        'port',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeId: config.decodeBinary<List<int>?>(
        json.valueAs('nodeId', normalizeKeyLookup: config.normalizeKeys),
      ),
      addressIpv6: config.decodeBinary<List<int>?>(
        json.valueAs('addressIpv6', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronEndpoint.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronEndpoint(
      address: decode.getBytes<List<int>?>(1),
      port: decode.getInt<int?>(2),
      nodeId: decode.getBytes<List<int>?>(3),
      addressIpv6: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolEndpoint;
}

class TronPingMessage extends TronProtoMessage {
  final TronEndpoint? from;

  final TronEndpoint? to;

  final int? version;

  final BigInt? timestamp;

  const TronPingMessage({this.from, this.to, this.version, this.timestamp});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [from, to, version, timestamp];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'from': config.encodeMessage(from),
      'to': config.encodeMessage(to),
      'version': version,
      'timestamp': config.encodeBigint(timestamp),
    }.notNullValue;
  }

  factory TronPingMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPingMessage(
      from: json.valueTo<TronEndpoint?, Object>(
        key: 'from',
        parse:
            (v) => TronEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      to: json.valueTo<TronEndpoint?, Object>(
        key: 'to',
        parse:
            (v) => TronEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronPingMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPingMessage(
      from: decode.messageTo<TronEndpoint?>(
        1,
        (b) => TronEndpoint.deserialize(b),
      ),
      to: decode.messageTo<TronEndpoint?>(
        2,
        (b) => TronEndpoint.deserialize(b),
      ),
      version: decode.getInt<int?>(3),
      timestamp: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPingMessage;
}

class TronPongMessage extends TronProtoMessage {
  final TronEndpoint? from;

  final int? echo;

  final BigInt? timestamp;

  const TronPongMessage({this.from, this.echo, this.timestamp});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [from, echo, timestamp];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'from': config.encodeMessage(from),
      'echo': echo,
      'timestamp': config.encodeBigint(timestamp),
    }.notNullValue;
  }

  factory TronPongMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPongMessage(
      from: json.valueTo<TronEndpoint?, Object>(
        key: 'from',
        parse:
            (v) => TronEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      echo: json.valueAsInt<int?>(
        'echo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronPongMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPongMessage(
      from: decode.messageTo<TronEndpoint?>(
        1,
        (b) => TronEndpoint.deserialize(b),
      ),
      echo: decode.getInt<int?>(2),
      timestamp: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPongMessage;
}

class TronFindNeighbours extends TronProtoMessage {
  final TronEndpoint? from;

  final List<int>? targetId;

  final BigInt? timestamp;

  const TronFindNeighbours({this.from, this.targetId, this.timestamp});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [from, targetId, timestamp];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'from': config.encodeMessage(from),
      'targetId': config.encodeBinary(targetId),
      'timestamp': config.encodeBigint(timestamp),
    }.notNullValue;
  }

  factory TronFindNeighbours.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronFindNeighbours(
      from: json.valueTo<TronEndpoint?, Object>(
        key: 'from',
        parse:
            (v) => TronEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      targetId: config.decodeBinary<List<int>?>(
        json.valueAs('targetId', normalizeKeyLookup: config.normalizeKeys),
      ),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronFindNeighbours.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronFindNeighbours(
      from: decode.messageTo<TronEndpoint?>(
        1,
        (b) => TronEndpoint.deserialize(b),
      ),
      targetId: decode.getBytes<List<int>?>(2),
      timestamp: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolFindNeighbours;
}

class TronNeighbours extends TronProtoMessage {
  final TronEndpoint? from;

  final List<TronEndpoint> neighbours;

  final BigInt? timestamp;

  const TronNeighbours({this.from, this.neighbours = const [], this.timestamp});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [from, neighbours, timestamp];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'from': config.encodeMessage(from),
      'neighbours': neighbours.map((e) => config.encodeMessage(e)).toList(),
      'timestamp': config.encodeBigint(timestamp),
    }.notNullValue;
  }

  factory TronNeighbours.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNeighbours(
      from: json.valueTo<TronEndpoint?, Object>(
        key: 'from',
        parse:
            (v) => TronEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      neighbours:
          (json.valueEnsureAsList<dynamic>(
                'neighbours',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronEndpoint, Object>(
                  value: e,
                  parse:
                      (v) => TronEndpoint.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNeighbours.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNeighbours(
      from: decode.messageTo<TronEndpoint?>(
        1,
        (b) => TronEndpoint.deserialize(b),
      ),
      neighbours:
          decode
              .getListOfBytes(2)
              .map((b) => TronEndpoint.deserialize(b))
              .toList(),
      timestamp: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNeighbours;
}

class TronBackupMessage extends TronProtoMessage {
  final bool? flag;

  final int? priority;

  const TronBackupMessage({this.flag, this.priority});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bool(1), ProtoFieldConfig.int32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [flag, priority];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'flag': flag, 'priority': priority}.notNullValue;
  }

  factory TronBackupMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBackupMessage(
      flag: json.valueAsBool<bool?>(
        'flag',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      priority: json.valueAsInt<int?>(
        'priority',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBackupMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBackupMessage(
      flag: decode.getBool<bool?>(1),
      priority: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBackupMessage;
}

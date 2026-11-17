import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import 'package:on_chain/sui/src/serialization/protobuf/wkt.dart';

import "package:on_chain/sui/src/proto_messages/google/protobuf/src/timestamp.dart" as google_protobuf_timestamp;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/field_mask.dart" as google_protobuf_field_mask;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart" as sui_rpc_v2_object;
import "package:on_chain/sui/src/proto_messages/google/rpc/src/status.dart" as google_rpc_status;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/executed_transaction.dart" as sui_rpc_v2_executed_transaction;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/checkpoint.dart" as sui_rpc_v2_checkpoint;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/epoch.dart" as sui_rpc_v2_epoch;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/filter.dart" as sui_rpc_v2_filter;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/query_options.dart" as sui_rpc_v2_query_options;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/event.dart" as sui_rpc_v2_event;

class SuiGetServiceInfoRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetServiceInfoResponse> {
  const SuiGetServiceInfoRequest();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory SuiGetServiceInfoRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetServiceInfoRequest(
    );
  }

  factory SuiGetServiceInfoRequest.deserialize(List<int> bytes) {
    return SuiGetServiceInfoRequest(
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetServiceInfoRequest;
  @override
  SuiGetServiceInfoResponse onServiceResponse(List<int> bytes) {
    return SuiGetServiceInfoResponse.deserialize(bytes);
  }
  @override
  SuiGetServiceInfoResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetServiceInfoResponse.fromJson(json);
  }

}


class SuiGetServiceInfoResponse extends SuiProtoMessage {
    /// The chain identifier of the chain that this node is on.
  ///
  /// The chain identifier is the digest of the genesis checkpoint, the
  /// checkpoint with sequence number 0.
  final String? chainId;

    /// Human-readable name of the chain that this node is on.
  ///
  /// This is intended to be a human-readable name like `mainnet`, `testnet`, and so on.
  final String? chain;

    /// Current epoch of the node based on its highest executed checkpoint.
  final BigInt? epoch;

    /// Checkpoint height of the most recently executed checkpoint.
  final BigInt? checkpointHeight;

    /// Unix timestamp of the most recently executed checkpoint.
  final google_protobuf_timestamp.SuiTimestamp? timestamp;

    /// The lowest checkpoint for which checkpoints and transaction data are available.
  final BigInt? lowestAvailableCheckpoint;

    /// The lowest checkpoint for which object data is available.
  final BigInt? lowestAvailableCheckpointObjects;

    /// Software version of the service. Similar to the `server` http header.
  final String? server;

  const SuiGetServiceInfoResponse({
    this.chainId,
    this.chain,
    this.epoch,
    this.checkpointHeight,
    this.timestamp,
    this.lowestAvailableCheckpoint,
    this.lowestAvailableCheckpointObjects,
    this.server,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(6, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(7, hasOptionalFlags: true),
        ProtoFieldConfig.string(8, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        chainId,
        chain,
        epoch,
        checkpointHeight,
        timestamp,
        lowestAvailableCheckpoint,
        lowestAvailableCheckpointObjects,
        server,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'chain_id': chainId,
      'chain': chain,
      'epoch': config.encodeBigint(epoch),
      'checkpoint_height': config.encodeBigint(checkpointHeight),
      'timestamp': timestamp?.toRfc3339(),
      'lowest_available_checkpoint': config.encodeBigint(lowestAvailableCheckpoint),
      'lowest_available_checkpoint_objects': config.encodeBigint(lowestAvailableCheckpointObjects),
      'server': server,
    };
  }


  factory SuiGetServiceInfoResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetServiceInfoResponse(
      chainId: json.valueAsString<String?>('chain_id', normalizeKeyLookup: config.normalizeKeys),
      chain: json.valueAsString<String?>('chain', normalizeKeyLookup: config.normalizeKeys),
      epoch: json.valueAsBigInt<BigInt?>('epoch', normalizeKeyLookup: config.normalizeKeys),
      checkpointHeight: json.valueAsBigInt<BigInt?>('checkpoint_height', normalizeKeyLookup: config.normalizeKeys),
      timestamp: json.valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
        key: 'timestamp',
        parse: (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      lowestAvailableCheckpoint: json.valueAsBigInt<BigInt?>('lowest_available_checkpoint', normalizeKeyLookup: config.normalizeKeys),
      lowestAvailableCheckpointObjects: json.valueAsBigInt<BigInt?>('lowest_available_checkpoint_objects', normalizeKeyLookup: config.normalizeKeys),
      server: json.valueAsString<String?>('server', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiGetServiceInfoResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetServiceInfoResponse(
      chainId: decode.getString<String?>(1),
      chain: decode.getString<String?>(2),
      epoch: decode.getBigInt<BigInt?>(3),
      checkpointHeight: decode.getBigInt<BigInt?>(4),
      timestamp: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(5, (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b)),
      lowestAvailableCheckpoint: decode.getBigInt<BigInt?>(6),
      lowestAvailableCheckpointObjects: decode.getBigInt<BigInt?>(7),
      server: decode.getString<String?>(8),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetServiceInfoResponse;

}


class SuiGetObjectRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetObjectResponse> {
    /// Required. The `ObjectId` of the requested object.
  final String? objectId;

    /// Request a specific version of the object.
  /// If no version is specified, and the object is live, then the latest
  /// version of the object is returned.
  final BigInt? version;

    /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `object_id,version,digest`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  const SuiGetObjectRequest({
    this.objectId,
    this.version,
    this.readMask,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        objectId,
        version,
        readMask,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'object_id': objectId,
      'version': config.encodeBigint(version),
      'read_mask': config.encodeMessage(readMask),
    };
  }


  factory SuiGetObjectRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetObjectRequest(
      objectId: json.valueAsString<String?>('object_id', normalizeKeyLookup: config.normalizeKeys),
      version: json.valueAsBigInt<BigInt?>('version', normalizeKeyLookup: config.normalizeKeys),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetObjectRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetObjectRequest(
      objectId: decode.getString<String?>(1),
      version: decode.getBigInt<BigInt?>(2),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(3, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetObjectRequest;
  @override
  SuiGetObjectResponse onServiceResponse(List<int> bytes) {
    return SuiGetObjectResponse.deserialize(bytes);
  }
  @override
  SuiGetObjectResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetObjectResponse.fromJson(json);
  }

}


class SuiGetObjectResponse extends SuiProtoMessage {
  final sui_rpc_v2_object.SuiObject? object;

  const SuiGetObjectResponse({
    this.object,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        object,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'object': config.encodeMessage(object),
    };
  }


  factory SuiGetObjectResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetObjectResponse(
      object: json.valueTo<sui_rpc_v2_object.SuiObject?, Object>(
        key: 'object',
        parse: (v) => sui_rpc_v2_object.SuiObject.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetObjectResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetObjectResponse(
      object: decode.messageTo<sui_rpc_v2_object.SuiObject?>(1, (b) => sui_rpc_v2_object.SuiObject.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetObjectResponse;

}


class SuiBatchGetObjectsRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiBatchGetObjectsResponse> {
  final List<SuiGetObjectRequest> requests;

    /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `object_id,version,digest`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  const SuiBatchGetObjectsRequest({
    this.requests = const [],
    this.readMask,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        requests,
        readMask,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'requests': requests.map((e) => config.encodeMessage(e)).toList(),
      'read_mask': config.encodeMessage(readMask),
    };
  }


  factory SuiBatchGetObjectsRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiBatchGetObjectsRequest(
      requests: (json.valueEnsureAsList<dynamic>('requests', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiGetObjectRequest, Object>(
          value: e,
          parse: (v) => SuiGetObjectRequest.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiBatchGetObjectsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiBatchGetObjectsRequest(
      requests: decode.getListOfBytes(1).map((b) => SuiGetObjectRequest.deserialize(b)).toList(),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(2, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2BatchGetObjectsRequest;
  @override
  SuiBatchGetObjectsResponse onServiceResponse(List<int> bytes) {
    return SuiBatchGetObjectsResponse.deserialize(bytes);
  }
  @override
  SuiBatchGetObjectsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiBatchGetObjectsResponse.fromJson(json);
  }

}


class SuiBatchGetObjectsResponse extends SuiProtoMessage {
  final List<SuiGetObjectResult> objects;

  const SuiBatchGetObjectsResponse({
    this.objects = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        objects,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'objects': objects.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiBatchGetObjectsResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiBatchGetObjectsResponse(
      objects: (json.valueEnsureAsList<dynamic>('objects', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiGetObjectResult, Object>(
          value: e,
          parse: (v) => SuiGetObjectResult.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiBatchGetObjectsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiBatchGetObjectsResponse(
      objects: decode.getListOfBytes(1).map((b) => SuiGetObjectResult.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2BatchGetObjectsResponse;

}


class SuiGetObjectResult extends SuiProtoMessage {
  final sui_rpc_v2_object.SuiObject? object;

  final google_rpc_status.SuiStatus? error;

  const SuiGetObjectResult({
    this.object,
    this.error,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        object,
        error,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'object': config.encodeMessage(object),
      'error': config.encodeMessage(error),
    };
  }


  factory SuiGetObjectResult.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetObjectResult(
      object: json.valueTo<sui_rpc_v2_object.SuiObject?, Object>(
        key: 'object',
        parse: (v) => sui_rpc_v2_object.SuiObject.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      error: json.valueTo<google_rpc_status.SuiStatus?, Object>(
        key: 'error',
        parse: (v) => google_rpc_status.SuiStatus.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetObjectResult.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetObjectResult(
      object: decode.messageTo<sui_rpc_v2_object.SuiObject?>(1, (b) => sui_rpc_v2_object.SuiObject.deserialize(b)),
      error: decode.messageTo<google_rpc_status.SuiStatus?>(2, (b) => google_rpc_status.SuiStatus.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetObjectResult;

}


class SuiGetTransactionRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetTransactionResponse> {
    /// Required. The digest of the requested transaction.
  final String? digest;

    /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `digest`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  const SuiGetTransactionRequest({
    this.digest,
    this.readMask,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        digest,
        readMask,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'digest': digest,
      'read_mask': config.encodeMessage(readMask),
    };
  }


  factory SuiGetTransactionRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetTransactionRequest(
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetTransactionRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetTransactionRequest(
      digest: decode.getString<String?>(1),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(2, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetTransactionRequest;
  @override
  SuiGetTransactionResponse onServiceResponse(List<int> bytes) {
    return SuiGetTransactionResponse.deserialize(bytes);
  }
  @override
  SuiGetTransactionResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetTransactionResponse.fromJson(json);
  }

}


class SuiGetTransactionResponse extends SuiProtoMessage {
  final sui_rpc_v2_executed_transaction.SuiExecutedTransaction? transaction;

  const SuiGetTransactionResponse({
    this.transaction,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transaction,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transaction': config.encodeMessage(transaction),
    };
  }


  factory SuiGetTransactionResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetTransactionResponse(
      transaction: json.valueTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?, Object>(
        key: 'transaction',
        parse: (v) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetTransactionResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetTransactionResponse(
      transaction: decode.messageTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?>(1, (b) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetTransactionResponse;

}


class SuiBatchGetTransactionsRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiBatchGetTransactionsResponse> {
    /// Required. The digests of the requested transactions.
  final List<String> digests;

    /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `digest`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  const SuiBatchGetTransactionsRequest({
    this.digests = const [],
    this.readMask,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.string,
        ),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        digests,
        readMask,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'digests': digests.map((e) => e).toList(),
      'read_mask': config.encodeMessage(readMask),
    };
  }


  factory SuiBatchGetTransactionsRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiBatchGetTransactionsRequest(
      digests: (json.valueEnsureAsList<dynamic>('digests', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsString<String>(e)).toList(),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiBatchGetTransactionsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiBatchGetTransactionsRequest(
      digests: decode.getListOrEmpty<String>(1),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(2, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2BatchGetTransactionsRequest;
  @override
  SuiBatchGetTransactionsResponse onServiceResponse(List<int> bytes) {
    return SuiBatchGetTransactionsResponse.deserialize(bytes);
  }
  @override
  SuiBatchGetTransactionsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiBatchGetTransactionsResponse.fromJson(json);
  }

}


class SuiBatchGetTransactionsResponse extends SuiProtoMessage {
  final List<SuiGetTransactionResult> transactions;

  const SuiBatchGetTransactionsResponse({
    this.transactions = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transactions,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiBatchGetTransactionsResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiBatchGetTransactionsResponse(
      transactions: (json.valueEnsureAsList<dynamic>('transactions', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiGetTransactionResult, Object>(
          value: e,
          parse: (v) => SuiGetTransactionResult.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiBatchGetTransactionsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiBatchGetTransactionsResponse(
      transactions: decode.getListOfBytes(1).map((b) => SuiGetTransactionResult.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2BatchGetTransactionsResponse;

}


class SuiGetTransactionResult extends SuiProtoMessage {
  final sui_rpc_v2_executed_transaction.SuiExecutedTransaction? transaction;

  final google_rpc_status.SuiStatus? error;

  const SuiGetTransactionResult({
    this.transaction,
    this.error,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transaction,
        error,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transaction': config.encodeMessage(transaction),
      'error': config.encodeMessage(error),
    };
  }


  factory SuiGetTransactionResult.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetTransactionResult(
      transaction: json.valueTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?, Object>(
        key: 'transaction',
        parse: (v) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      error: json.valueTo<google_rpc_status.SuiStatus?, Object>(
        key: 'error',
        parse: (v) => google_rpc_status.SuiStatus.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetTransactionResult.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetTransactionResult(
      transaction: decode.messageTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?>(1, (b) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.deserialize(b)),
      error: decode.messageTo<google_rpc_status.SuiStatus?>(2, (b) => google_rpc_status.SuiStatus.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetTransactionResult;

}


class SuiGetCheckpointRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetCheckpointResponse> {
    /// If neither is provided, return the latest
  /// The sequence number of the requested checkpoint.
  final BigInt? sequenceNumber;

    /// The digest of the requested checkpoint.
  final String? digest;

    /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `sequence_number,digest`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  const SuiGetCheckpointRequest({
    this.sequenceNumber,
    this.digest,
    this.readMask,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sequenceNumber,
        digest,
        readMask,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sequence_number': config.encodeBigint(sequenceNumber),
      'digest': digest,
      'read_mask': config.encodeMessage(readMask),
    };
  }


  factory SuiGetCheckpointRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetCheckpointRequest(
      sequenceNumber: json.valueAsBigInt<BigInt?>('sequence_number', normalizeKeyLookup: config.normalizeKeys),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetCheckpointRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetCheckpointRequest(
      sequenceNumber: decode.getBigInt<BigInt?>(1),
      digest: decode.getString<String?>(2),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(3, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetCheckpointRequest;
  @override
  SuiGetCheckpointResponse onServiceResponse(List<int> bytes) {
    return SuiGetCheckpointResponse.deserialize(bytes);
  }
  @override
  SuiGetCheckpointResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetCheckpointResponse.fromJson(json);
  }

}


class SuiGetCheckpointResponse extends SuiProtoMessage {
  final sui_rpc_v2_checkpoint.SuiCheckpoint? checkpoint;

  const SuiGetCheckpointResponse({
    this.checkpoint,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        checkpoint,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'checkpoint': config.encodeMessage(checkpoint),
    };
  }


  factory SuiGetCheckpointResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetCheckpointResponse(
      checkpoint: json.valueTo<sui_rpc_v2_checkpoint.SuiCheckpoint?, Object>(
        key: 'checkpoint',
        parse: (v) => sui_rpc_v2_checkpoint.SuiCheckpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetCheckpointResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetCheckpointResponse(
      checkpoint: decode.messageTo<sui_rpc_v2_checkpoint.SuiCheckpoint?>(1, (b) => sui_rpc_v2_checkpoint.SuiCheckpoint.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetCheckpointResponse;

}


class SuiGetEpochRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiGetEpochResponse> {
    /// The requested epoch.
  /// If no epoch is provided the current epoch will be returned.
  final BigInt? epoch;

    /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `epoch`.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  const SuiGetEpochRequest({
    this.epoch,
    this.readMask,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        epoch,
        readMask,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'epoch': config.encodeBigint(epoch),
      'read_mask': config.encodeMessage(readMask),
    };
  }


  factory SuiGetEpochRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetEpochRequest(
      epoch: json.valueAsBigInt<BigInt?>('epoch', normalizeKeyLookup: config.normalizeKeys),
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetEpochRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetEpochRequest(
      epoch: decode.getBigInt<BigInt?>(1),
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(2, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetEpochRequest;
  @override
  SuiGetEpochResponse onServiceResponse(List<int> bytes) {
    return SuiGetEpochResponse.deserialize(bytes);
  }
  @override
  SuiGetEpochResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiGetEpochResponse.fromJson(json);
  }

}


class SuiGetEpochResponse extends SuiProtoMessage {
  final sui_rpc_v2_epoch.SuiEpoch? epoch;

  const SuiGetEpochResponse({
    this.epoch,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        epoch,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'epoch': config.encodeMessage(epoch),
    };
  }


  factory SuiGetEpochResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiGetEpochResponse(
      epoch: json.valueTo<sui_rpc_v2_epoch.SuiEpoch?, Object>(
        key: 'epoch',
        parse: (v) => sui_rpc_v2_epoch.SuiEpoch.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiGetEpochResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGetEpochResponse(
      epoch: decode.messageTo<sui_rpc_v2_epoch.SuiEpoch?>(1, (b) => sui_rpc_v2_epoch.SuiEpoch.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2GetEpochResponse;

}


/// Request message for LedgerService.ListCheckpoints.
class SuiListCheckpointsRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiListCheckpointsResponse> {
    /// Optional. Mask for specifying which parts of the Checkpoint should be
  /// returned (e.g. summary, contents, signatures).
  final google_protobuf_field_mask.SuiFieldMask? readMask;

    /// Optional. Start of the checkpoint range to query (inclusive). Defaults to
  /// genesis.
  final BigInt? startCheckpoint;

    /// Optional. End of the checkpoint range to query (exclusive). Defaults to the
  /// current indexed ledger tip.
  final BigInt? endCheckpoint;

    /// Optional. DNF filter over indexed transaction dimensions. A checkpoint
  /// matches if any transaction it contains satisfies the filter. If absent,
  /// all checkpoints in the range are returned.
  final sui_rpc_v2_filter.SuiTransactionFilter? filter;

    /// Optional cursor-bounded query options. If unspecified, reads in ascending
  /// order with the default item limit. The server enforces a maximum item
  /// limit and silently coerces larger values down to it. To paginate, pass
  /// the last received `Watermark.cursor` as `options.after` (ascending) or
  /// `options.before` (descending) on the next request.
  final sui_rpc_v2_query_options.SuiQueryOptions? options;

  const SuiListCheckpointsRequest({
    this.readMask,
    this.startCheckpoint,
    this.endCheckpoint,
    this.filter,
    this.options,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        readMask,
        startCheckpoint,
        endCheckpoint,
        filter,
        options,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'read_mask': config.encodeMessage(readMask),
      'start_checkpoint': config.encodeBigint(startCheckpoint),
      'end_checkpoint': config.encodeBigint(endCheckpoint),
      'filter': config.encodeMessage(filter),
      'options': config.encodeMessage(options),
    };
  }


  factory SuiListCheckpointsRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListCheckpointsRequest(
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      startCheckpoint: json.valueAsBigInt<BigInt?>('start_checkpoint', normalizeKeyLookup: config.normalizeKeys),
      endCheckpoint: json.valueAsBigInt<BigInt?>('end_checkpoint', normalizeKeyLookup: config.normalizeKeys),
      filter: json.valueTo<sui_rpc_v2_filter.SuiTransactionFilter?, Object>(
        key: 'filter',
        parse: (v) => sui_rpc_v2_filter.SuiTransactionFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      options: json.valueTo<sui_rpc_v2_query_options.SuiQueryOptions?, Object>(
        key: 'options',
        parse: (v) => sui_rpc_v2_query_options.SuiQueryOptions.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiListCheckpointsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListCheckpointsRequest(
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(1, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
      startCheckpoint: decode.getBigInt<BigInt?>(2),
      endCheckpoint: decode.getBigInt<BigInt?>(3),
      filter: decode.messageTo<sui_rpc_v2_filter.SuiTransactionFilter?>(4, (b) => sui_rpc_v2_filter.SuiTransactionFilter.deserialize(b)),
      options: decode.messageTo<sui_rpc_v2_query_options.SuiQueryOptions?>(5, (b) => sui_rpc_v2_query_options.SuiQueryOptions.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListCheckpointsRequest;
  @override
  SuiListCheckpointsResponse onServiceResponse(List<int> bytes) {
    return SuiListCheckpointsResponse.deserialize(bytes);
  }
  @override
  SuiListCheckpointsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiListCheckpointsResponse.fromJson(json);
  }

}


/// Response message for LedgerService.ListCheckpoints.
///
/// Every frame carries a `watermark` with a safe resume cursor. A frame
/// with `checkpoint` set delivers one matching item; a frame without it reports
/// scan progress or terminal completion. Watermarks never regress in the
/// requested ordering but may repeat.
///
/// `end` is set exactly once, on the final frame of a successful stream. For
/// `QUERY_END_REASON_ITEM_LIMIT`, that frame also carries the final item. For
/// every other end reason, the final frame has no `checkpoint` payload.
class SuiListCheckpointsResponse extends SuiProtoMessage {
    /// One matching checkpoint.
  final sui_rpc_v2_checkpoint.SuiCheckpoint? checkpoint;

    /// Progress watermark as of this frame. Present on every frame. A
  /// ScanLimit terminal watermark may repeat the previous frame's cursor when
  /// its authoritative scan frontier was already emitted.
  final sui_rpc_v2_query_options.SuiWatermark? watermark;

    /// Set exactly once, on the final frame of a successful query stream.
  final sui_rpc_v2_query_options.SuiQueryEnd? end;

  const SuiListCheckpointsResponse({
    this.checkpoint,
    this.watermark,
    this.end,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        checkpoint,
        watermark,
        end,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'checkpoint': config.encodeMessage(checkpoint),
      'watermark': config.encodeMessage(watermark),
      'end': config.encodeMessage(end),
    };
  }


  factory SuiListCheckpointsResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListCheckpointsResponse(
      checkpoint: json.valueTo<sui_rpc_v2_checkpoint.SuiCheckpoint?, Object>(
        key: 'checkpoint',
        parse: (v) => sui_rpc_v2_checkpoint.SuiCheckpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      watermark: json.valueTo<sui_rpc_v2_query_options.SuiWatermark?, Object>(
        key: 'watermark',
        parse: (v) => sui_rpc_v2_query_options.SuiWatermark.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      end: json.valueTo<sui_rpc_v2_query_options.SuiQueryEnd?, Object>(
        key: 'end',
        parse: (v) => sui_rpc_v2_query_options.SuiQueryEnd.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiListCheckpointsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListCheckpointsResponse(
      checkpoint: decode.messageTo<sui_rpc_v2_checkpoint.SuiCheckpoint?>(1, (b) => sui_rpc_v2_checkpoint.SuiCheckpoint.deserialize(b)),
      watermark: decode.messageTo<sui_rpc_v2_query_options.SuiWatermark?>(2, (b) => sui_rpc_v2_query_options.SuiWatermark.deserialize(b)),
      end: decode.messageTo<sui_rpc_v2_query_options.SuiQueryEnd?>(3, (b) => sui_rpc_v2_query_options.SuiQueryEnd.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListCheckpointsResponse;

}


/// Request message for LedgerService.ListTransactions.
class SuiListTransactionsRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiListTransactionsResponse> {
    /// Optional. Mask for specifying which parts of the ExecutedTransaction
  /// should be returned.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

    /// Optional. Start of the checkpoint range to query (inclusive). Defaults to
  /// genesis.
  final BigInt? startCheckpoint;

    /// Optional. End of the checkpoint range to query (exclusive). Defaults to the
  /// current indexed ledger tip.
  final BigInt? endCheckpoint;

    /// Optional. DNF filter over indexed dimensions.
  /// If absent, all transactions in the range are returned.
  final sui_rpc_v2_filter.SuiTransactionFilter? filter;

    /// Optional cursor-bounded query options. If unspecified, reads in ascending
  /// order with the default item limit. The server enforces a maximum item
  /// limit and silently coerces larger values down to it. To paginate, pass
  /// the last received `Watermark.cursor` as `options.after` (ascending) or
  /// `options.before` (descending) on the next request.
  final sui_rpc_v2_query_options.SuiQueryOptions? options;

  const SuiListTransactionsRequest({
    this.readMask,
    this.startCheckpoint,
    this.endCheckpoint,
    this.filter,
    this.options,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        readMask,
        startCheckpoint,
        endCheckpoint,
        filter,
        options,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'read_mask': config.encodeMessage(readMask),
      'start_checkpoint': config.encodeBigint(startCheckpoint),
      'end_checkpoint': config.encodeBigint(endCheckpoint),
      'filter': config.encodeMessage(filter),
      'options': config.encodeMessage(options),
    };
  }


  factory SuiListTransactionsRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListTransactionsRequest(
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      startCheckpoint: json.valueAsBigInt<BigInt?>('start_checkpoint', normalizeKeyLookup: config.normalizeKeys),
      endCheckpoint: json.valueAsBigInt<BigInt?>('end_checkpoint', normalizeKeyLookup: config.normalizeKeys),
      filter: json.valueTo<sui_rpc_v2_filter.SuiTransactionFilter?, Object>(
        key: 'filter',
        parse: (v) => sui_rpc_v2_filter.SuiTransactionFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      options: json.valueTo<sui_rpc_v2_query_options.SuiQueryOptions?, Object>(
        key: 'options',
        parse: (v) => sui_rpc_v2_query_options.SuiQueryOptions.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiListTransactionsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListTransactionsRequest(
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(1, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
      startCheckpoint: decode.getBigInt<BigInt?>(2),
      endCheckpoint: decode.getBigInt<BigInt?>(3),
      filter: decode.messageTo<sui_rpc_v2_filter.SuiTransactionFilter?>(4, (b) => sui_rpc_v2_filter.SuiTransactionFilter.deserialize(b)),
      options: decode.messageTo<sui_rpc_v2_query_options.SuiQueryOptions?>(5, (b) => sui_rpc_v2_query_options.SuiQueryOptions.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListTransactionsRequest;
  @override
  SuiListTransactionsResponse onServiceResponse(List<int> bytes) {
    return SuiListTransactionsResponse.deserialize(bytes);
  }
  @override
  SuiListTransactionsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiListTransactionsResponse.fromJson(json);
  }

}


/// Response message for LedgerService.ListTransactions.
///
/// Every frame carries a `watermark` with a safe resume cursor. A frame
/// with `transaction` set delivers one matching item; a frame without it reports
/// scan progress or terminal completion. Watermarks never regress in the
/// requested ordering but may repeat.
///
/// `end` is set exactly once, on the final frame of a successful stream. For
/// `QUERY_END_REASON_ITEM_LIMIT`, that frame also carries the final item. For
/// every other end reason, the final frame has no `transaction` payload.
class SuiListTransactionsResponse extends SuiProtoMessage {
    /// One matching transaction. Its position within the containing checkpoint
  /// is reported by `ExecutedTransaction.transaction_index`.
  final sui_rpc_v2_executed_transaction.SuiExecutedTransaction? transaction;

    /// Progress watermark as of this frame. Present on every frame. A
  /// ScanLimit terminal watermark may repeat the previous frame's cursor when
  /// its authoritative scan frontier was already emitted.
  final sui_rpc_v2_query_options.SuiWatermark? watermark;

    /// Set exactly once, on the final frame of a successful query stream.
  final sui_rpc_v2_query_options.SuiQueryEnd? end;

  const SuiListTransactionsResponse({
    this.transaction,
    this.watermark,
    this.end,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transaction,
        watermark,
        end,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'transaction': config.encodeMessage(transaction),
      'watermark': config.encodeMessage(watermark),
      'end': config.encodeMessage(end),
    };
  }


  factory SuiListTransactionsResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListTransactionsResponse(
      transaction: json.valueTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?, Object>(
        key: 'transaction',
        parse: (v) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      watermark: json.valueTo<sui_rpc_v2_query_options.SuiWatermark?, Object>(
        key: 'watermark',
        parse: (v) => sui_rpc_v2_query_options.SuiWatermark.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      end: json.valueTo<sui_rpc_v2_query_options.SuiQueryEnd?, Object>(
        key: 'end',
        parse: (v) => sui_rpc_v2_query_options.SuiQueryEnd.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiListTransactionsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListTransactionsResponse(
      transaction: decode.messageTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?>(1, (b) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.deserialize(b)),
      watermark: decode.messageTo<sui_rpc_v2_query_options.SuiWatermark?>(2, (b) => sui_rpc_v2_query_options.SuiWatermark.deserialize(b)),
      end: decode.messageTo<sui_rpc_v2_query_options.SuiQueryEnd?>(3, (b) => sui_rpc_v2_query_options.SuiQueryEnd.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListTransactionsResponse;

}


/// Request message for LedgerService.ListEvents.
class SuiListEventsRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiListEventsResponse> {
    /// Optional. Mask for specifying which parts of the Event should be returned.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

    /// Optional. Start of the checkpoint range to query (inclusive). Defaults to
  /// genesis.
  final BigInt? startCheckpoint;

    /// Optional. End of the checkpoint range to query (exclusive). Defaults to the
  /// current indexed ledger tip.
  final BigInt? endCheckpoint;

    /// Optional. DNF filter over indexed dimensions.
  /// If absent, all events in the range are returned.
  final sui_rpc_v2_filter.SuiEventFilter? filter;

    /// Optional cursor-bounded query options. If unspecified, reads in ascending
  /// order with the default item limit. The server enforces a maximum item
  /// limit and silently coerces larger values down to it. To paginate, pass
  /// the last received `Watermark.cursor` as `options.after` (ascending) or
  /// `options.before` (descending) on the next request.
  final sui_rpc_v2_query_options.SuiQueryOptions? options;

  const SuiListEventsRequest({
    this.readMask,
    this.startCheckpoint,
    this.endCheckpoint,
    this.filter,
    this.options,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        readMask,
        startCheckpoint,
        endCheckpoint,
        filter,
        options,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'read_mask': config.encodeMessage(readMask),
      'start_checkpoint': config.encodeBigint(startCheckpoint),
      'end_checkpoint': config.encodeBigint(endCheckpoint),
      'filter': config.encodeMessage(filter),
      'options': config.encodeMessage(options),
    };
  }


  factory SuiListEventsRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListEventsRequest(
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse: (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      startCheckpoint: json.valueAsBigInt<BigInt?>('start_checkpoint', normalizeKeyLookup: config.normalizeKeys),
      endCheckpoint: json.valueAsBigInt<BigInt?>('end_checkpoint', normalizeKeyLookup: config.normalizeKeys),
      filter: json.valueTo<sui_rpc_v2_filter.SuiEventFilter?, Object>(
        key: 'filter',
        parse: (v) => sui_rpc_v2_filter.SuiEventFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      options: json.valueTo<sui_rpc_v2_query_options.SuiQueryOptions?, Object>(
        key: 'options',
        parse: (v) => sui_rpc_v2_query_options.SuiQueryOptions.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiListEventsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListEventsRequest(
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(1, (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b)),
      startCheckpoint: decode.getBigInt<BigInt?>(2),
      endCheckpoint: decode.getBigInt<BigInt?>(3),
      filter: decode.messageTo<sui_rpc_v2_filter.SuiEventFilter?>(4, (b) => sui_rpc_v2_filter.SuiEventFilter.deserialize(b)),
      options: decode.messageTo<sui_rpc_v2_query_options.SuiQueryOptions?>(5, (b) => sui_rpc_v2_query_options.SuiQueryOptions.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListEventsRequest;
  @override
  SuiListEventsResponse onServiceResponse(List<int> bytes) {
    return SuiListEventsResponse.deserialize(bytes);
  }
  @override
  SuiListEventsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiListEventsResponse.fromJson(json);
  }

}


/// Response message for LedgerService.ListEvents.
///
/// Every frame carries a `watermark` with a safe resume cursor. A frame
/// with `event` set delivers one matching item; a frame without it reports scan
/// progress or terminal completion. Watermarks never regress in the requested
/// ordering but may repeat.
///
/// `end` is set exactly once, on the final frame of a successful stream. For
/// `QUERY_END_REASON_ITEM_LIMIT`, that frame also carries the final item. For
/// every other end reason, the final frame has no `event` payload.
class SuiListEventsResponse extends SuiProtoMessage {
    /// One matching event. Its ledger position -- containing checkpoint,
  /// emitting transaction digest and offset, and index within that
  /// transaction's event list -- is reported by the corresponding fields on
  /// `Event`.
  final sui_rpc_v2_event.SuiEvent? event;

    /// Progress watermark as of this frame. Present on every frame. A
  /// ScanLimit terminal watermark may repeat the previous frame's cursor when
  /// its authoritative scan frontier was already emitted.
  final sui_rpc_v2_query_options.SuiWatermark? watermark;

    /// Set exactly once, on the final frame of a successful query stream.
  final sui_rpc_v2_query_options.SuiQueryEnd? end;

  const SuiListEventsResponse({
    this.event,
    this.watermark,
    this.end,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        event,
        watermark,
        end,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'event': config.encodeMessage(event),
      'watermark': config.encodeMessage(watermark),
      'end': config.encodeMessage(end),
    };
  }


  factory SuiListEventsResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListEventsResponse(
      event: json.valueTo<sui_rpc_v2_event.SuiEvent?, Object>(
        key: 'event',
        parse: (v) => sui_rpc_v2_event.SuiEvent.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      watermark: json.valueTo<sui_rpc_v2_query_options.SuiWatermark?, Object>(
        key: 'watermark',
        parse: (v) => sui_rpc_v2_query_options.SuiWatermark.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      end: json.valueTo<sui_rpc_v2_query_options.SuiQueryEnd?, Object>(
        key: 'end',
        parse: (v) => sui_rpc_v2_query_options.SuiQueryEnd.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiListEventsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListEventsResponse(
      event: decode.messageTo<sui_rpc_v2_event.SuiEvent?>(1, (b) => sui_rpc_v2_event.SuiEvent.deserialize(b)),
      watermark: decode.messageTo<sui_rpc_v2_query_options.SuiWatermark?>(2, (b) => sui_rpc_v2_query_options.SuiWatermark.deserialize(b)),
      end: decode.messageTo<sui_rpc_v2_query_options.SuiQueryEnd?>(3, (b) => sui_rpc_v2_query_options.SuiQueryEnd.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ListEventsResponse;

}



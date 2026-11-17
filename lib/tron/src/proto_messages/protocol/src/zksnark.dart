import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart" as protocol_contracts;

enum TronZksnarkResponseCode implements ProtoEnumVariant {
  success(0, 'SUCCESS'),
  failed(1, 'FAILED');

  const TronZksnarkResponseCode(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronZksnarkResponseCode fromValue(int? value) {
    value ??=0;
    return TronZksnarkResponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TronZksnarkResponseCode found for the given value. $value", details: {"name": "TronZksnarkResponseCode", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronZksnarkResponseCode from(Object? value) {
    value ??=0;
    return TronZksnarkResponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TronZksnarkResponseCode found for the given value. $value", details: {"name": "TronZksnarkResponseCode", "value": value?.toString()})
    );
  }

}


class TronZksnarkRequest extends TronProtoMessage {
  final protocol_contracts.TronTransaction? transaction;

  final List<int>? sighash;

  final BigInt? valueBalance;

  final String? txId;

  const TronZksnarkRequest({
    this.transaction,
    this.sighash,
    this.valueBalance,
    this.txId,
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
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.string(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        transaction,
        sighash,
        valueBalance,
        txId,
      ];


  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return {
      'transaction': config.encodeMessage(transaction),
      'sighash': config.encodeBinary(sighash),
      'valueBalance': config.encodeBigint(valueBalance),
      'txId': txId,
    }.notNullValue;
  }


  factory TronZksnarkRequest.fromJson(Map<String, dynamic> json, {TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return TronZksnarkRequest(
      transaction: json.valueTo<protocol_contracts.TronTransaction?, Object>(
        key: 'transaction',
        parse: (v) => protocol_contracts.TronTransaction.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      sighash: config.decodeBinary<List<int>?>(json.valueAs('sighash', normalizeKeyLookup: config.normalizeKeys)),
      valueBalance: json.valueAsBigInt<BigInt?>('valueBalance', normalizeKeyLookup: config.normalizeKeys),
      txId: json.valueAsString<String?>('txId', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory TronZksnarkRequest.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronZksnarkRequest(
      transaction: decode.messageTo<protocol_contracts.TronTransaction?>(1, (b) => protocol_contracts.TronTransaction.deserialize(b)),
      sighash: decode.getBytes<List<int>?>(2),
      valueBalance: decode.getBigInt<BigInt?>(3),
      txId: decode.getString<String?>(4),
    );
  }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolZksnarkRequest;

}


class TronZksnarkResponse extends TronProtoMessage {
  final TronZksnarkResponseCode? code;

  const TronZksnarkResponse({
    this.code,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        code,
      ];


  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return {
      'code': config.encodeEnum(code),
    }.notNullValue;
  }


  factory TronZksnarkResponse.fromJson(Map<String, dynamic> json, {TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return TronZksnarkResponse(
      code: json.valueTo<TronZksnarkResponseCode?, Object?>(
        key: 'code',
        parse: (v) => TronZksnarkResponseCode.from(v),
      ),
    );
  }

  factory TronZksnarkResponse.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronZksnarkResponse(
      code: decode.getEnum<TronZksnarkResponseCode?>(1, TronZksnarkResponseCode.values),
    );
  }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolZksnarkResponse;

}



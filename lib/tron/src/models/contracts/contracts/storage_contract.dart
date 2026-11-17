import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

class TronUpdateBrokerageContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final int? brokerage;

  const TronUpdateBrokerageContract({
    required this.ownerAddress,
    this.brokerage,
  }) : super(TronTransactionContractContractType.updateBrokerageContract);

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
  List<Object?> get protoValues => [ownerAddress.toBytes(), brokerage];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'brokerage': brokerage,
    }.notNullValue;
  }

  factory TronUpdateBrokerageContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUpdateBrokerageContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      brokerage: json.valueAsInt<int?>(
        'brokerage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronUpdateBrokerageContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUpdateBrokerageContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      brokerage: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUpdateBrokerageContract;
}

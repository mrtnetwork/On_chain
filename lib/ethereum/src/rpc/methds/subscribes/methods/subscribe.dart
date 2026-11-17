import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class EthereumRequestETHSubscribeGeneric extends EthereumSubscribionRequest {
  final List<dynamic> params;
  EthereumRequestETHSubscribeGeneric(this.params);
  factory EthereumRequestETHSubscribeGeneric.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier:
          OnChainSerializationIdentifiers.ethereumRpcGenericSubscribtionParams,
      cborBytes: bytes,
      cborObject: object,
    );

    return EthereumRequestETHSubscribeGeneric(
      StringUtils.toJson(values.rawValueAt(0)),
    );
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      OnChainSerializationIdentifiers.ethereumRpcGenericSubscribtionParams;

  @override
  List<CborObject?> get serializationItems => [
    CborStringValue(StringUtils.fromJson(params, toStringEncodable: true)),
  ];

  @override
  String get method => EthereumMethods.ethSubscribe.value;

  @override
  List<dynamic> toJson() {
    return params;
  }
}

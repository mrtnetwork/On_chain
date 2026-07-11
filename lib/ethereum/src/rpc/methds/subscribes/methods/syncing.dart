import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/const/constant.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class EthereumRequestETHSubscribeSyncing extends EthereumSubscribionRequest {
  EthereumRequestETHSubscribeSyncing();
  factory EthereumRequestETHSubscribeSyncing.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    CborTagSerializable.decodeTaggedValue(
      identifier:
          OnChainSerializationIdentifiers.ethereumRpcSyncingSubscribtionParams,
      cborBytes: bytes,
      cborObject: object,
    );

    return EthereumRequestETHSubscribeSyncing();
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      OnChainSerializationIdentifiers.ethereumRpcSyncingSubscribtionParams;

  @override
  String get method => EthereumMethods.ethSubscribe.value;

  @override
  List<dynamic> toJson() {
    return [EthereumRequestETHSubscribeConst.syncing];
  }
}

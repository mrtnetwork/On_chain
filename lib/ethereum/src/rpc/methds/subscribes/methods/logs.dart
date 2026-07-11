import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/const/constant.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class EthereumRequestETHSubscribeLogs extends EthereumSubscribionRequest {
  EthereumRequestETHSubscribeLogs({this.filter});
  final SubscribeLogsFilter? filter;
  factory EthereumRequestETHSubscribeLogs.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier:
          OnChainSerializationIdentifiers.ethereumRpcLogSubscribtionParams,
      cborBytes: bytes,
      cborObject: object,
    );

    return EthereumRequestETHSubscribeLogs(
      filter: values.maybeObjectAt<SubscribeLogsFilter, CborTagValue>(
        0,
        (e) => SubscribeLogsFilter.deserialize(obj: e),
      ),
    );
  }

  @override
  String get method => EthereumMethods.ethSubscribe.value;

  @override
  List<dynamic> toJson() {
    return [
      EthereumRequestETHSubscribeConst.logs,
      if (filter != null) filter!.toJson(),
    ];
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      OnChainSerializationIdentifiers.ethereumRpcLogSubscribtionParams;

  @override
  List<CborObject?> get serializationItems => [filter?.toCbor()];
}

class SubscribeLogsFilter with CborTagSerializable {
  final ETHAddress address;
  final List<String> topics;
  const SubscribeLogsFilter({required this.address, this.topics = const []});
  factory SubscribeLogsFilter.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.ethereumRpcLogsFilter,
      cborBytes: bytes,
      cborObject: obj,
    );
    return SubscribeLogsFilter(
      address: ETHAddress.deserializeIAddress(bytes: values.rawValueAt(0)),
      topics: values.listAt<CborStringValue>(1).map((e) => e.value).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {'address': address.address, 'topics': topics};
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      OnChainSerializationIdentifiers.ethereumRpcLogsFilter;

  @override
  List<CborObject?> get serializationItems => [
    CborBytesValue(address.encodeAsIAddress()),
    CborTagSerializable.listFromDynamic(topics.map((e) => e.toCbor()).toList()),
  ];
}

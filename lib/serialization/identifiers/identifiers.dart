import 'package:blockchain_utils/cbor/serialization/cbor/tag.dart';
import 'package:blockchain_utils/exception/exceptions.dart';

enum OnChainSerializationIdentifiers implements SerializationIdentifier {
  adaPluginError(15001),
  aptosPluginError(15002),
  ethereumPluginError(15003),
  eip4631Error(15004),
  bcsError(15005),
  solanaPlugin(15006),
  solidityAbiError(15007),
  suiPluginError(15008),
  tronPluginError(15009),
  ethereumRpcEvent(15010),
  ethereumRpcSubscribtionParams(15011),
  ethereumRpcLogSubscribtionParams(15012),
  ethereumRpcLogsFilter(15013),
  ethereumRpcHeadSubscribtionParams(15014),
  ethereumRpcPendingTxSubscribtionParams(15015),
  ethereumRpcSyncingSubscribtionParams(15016),
  ethereumRpcGenericSubscribtionParams(15017);

  @override
  final int id;
  const OnChainSerializationIdentifiers(this.id);

  static OnChainSerializationIdentifiers fromIdentifier(int? value) {
    return values.firstWhere(
      (e) => e.id == value,
      orElse:
          () =>
              throw ItemNotFoundException(
                name: "OnChainSerializationIdentifiers",
              ),
    );
  }

  @override
  bool isValid(int? tag) {
    return tag == id;
  }
}

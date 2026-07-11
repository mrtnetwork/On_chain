import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

class ADAPluginException extends OnChainPluginException {
  const ADAPluginException(super.message, {super.details});

  factory ADAPluginException.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.adaPluginError,
      cborBytes: bytes,
      cborObject: object,
    );
    return ADAPluginException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.adaPluginError;

  @override
  BlockchainNetwork get relatedNetwork => BlockchainNetwork.cardano;
}

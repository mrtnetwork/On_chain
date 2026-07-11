import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

class TronPluginException extends OnChainPluginException {
  const TronPluginException(super.message, {super.details});
  factory TronPluginException.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.tronPluginError,
      cborBytes: bytes,
      cborObject: object,
    );
    return TronPluginException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.tronPluginError;

  @override
  BlockchainNetwork? get relatedNetwork => BlockchainNetwork.tron;
}

import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

/// A custom exception for handling errors related to the Aptos plugin.
class DartAptosPluginException extends OnChainPluginException {
  const DartAptosPluginException(super.message, {super.details});

  factory DartAptosPluginException.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.aptosPluginError,
      cborBytes: bytes,
      cborObject: object,
    );
    return DartAptosPluginException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.aptosPluginError;

  @override
  BlockchainNetwork get relatedNetwork => BlockchainNetwork.aptos;
}

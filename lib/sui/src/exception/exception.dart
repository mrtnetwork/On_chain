import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

/// Custom exception for handling errors specific to the Dart Sui plugin.
class DartSuiPluginException extends OnChainPluginException {
  const DartSuiPluginException(super.message, {super.details});

  factory DartSuiPluginException.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.suiPluginError,
      cborBytes: bytes,
      cborObject: object,
    );
    return DartSuiPluginException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.suiPluginError;

  @override
  BlockchainNetwork? get relatedNetwork => BlockchainNetwork.sui;
}

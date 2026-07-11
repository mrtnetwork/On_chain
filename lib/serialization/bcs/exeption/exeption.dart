import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

/// Custom exception for errors related to the Move codec.
class BcsSerializationException extends OnChainPluginException {
  /// Constructor for [BcsSerializationException] with a message and optional details.
  const BcsSerializationException(super.message, {super.details});

  factory BcsSerializationException.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.bcsError,
      cborBytes: bytes,
      cborObject: object,
    );
    return BcsSerializationException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.bcsError;

  @override
  BlockchainNetwork? get relatedNetwork => null;
}

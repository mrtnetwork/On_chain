import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

class SolanaPluginException extends OnChainPluginException {
  const SolanaPluginException(super.message, {super.details});
  factory SolanaPluginException.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.solanaPlugin,
      cborBytes: bytes,
      cborObject: object,
    );
    return SolanaPluginException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.solanaPlugin;

  @override
  BlockchainNetwork? get relatedNetwork => BlockchainNetwork.solana;
}

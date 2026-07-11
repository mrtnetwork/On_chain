import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

class SolidityAbiException extends OnChainPluginException {
  const SolidityAbiException(super.message, {super.details});
  factory SolidityAbiException.deserialize({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.solidityAbiError,
      cborBytes: bytes,
      cborObject: object,
    );
    return SolidityAbiException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.solidityAbiError;

  @override
  BlockchainNetwork? get relatedNetwork => null;
}

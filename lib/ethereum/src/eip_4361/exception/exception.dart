import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:on_chain/exception/exception.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

class EIP4631Exception extends OnChainPluginException {
  const EIP4631Exception(super.message, {super.details});
  factory EIP4631Exception.deserialize({List<int>? bytes, CborObject? object}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.eip4631Error,
      cborBytes: bytes,
      cborObject: object,
    );
    return EIP4631Exception(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  OnChainSerializationIdentifiers get serializationIdentifier =>
      OnChainSerializationIdentifiers.eip4631Error;
  @override
  BlockchainNetwork? get relatedNetwork => null;
}

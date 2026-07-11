import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/serialization/cbor/exception.dart';
import 'package:blockchain_utils/cbor/serialization/cbor/tag.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/eip_4361/exception/exception.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/serialization/bcs/exeption/exeption.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solidity/abi/exception/abi_exception.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/tron/src/exception/exception.dart';

abstract class OnChainPluginException extends IException {
  const OnChainPluginException(super.message, {super.details});
  factory OnChainPluginException.deserialize({
    List<int>? cborBytes,
    CborObject? obj,
  }) {
    final decode = CborTagSerializable.decodeTaggedValueWithInfo(
      expectedTags: OnChainSerializationIdentifiers.values,
      cborBytes: cborBytes,
      cborObject: obj,
    );
    final OnChainSerializationIdentifiers error = decode.identifier;
    return switch (error) {
      OnChainSerializationIdentifiers.adaPluginError =>
        ADAPluginException.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.aptosPluginError =>
        DartAptosPluginException.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.ethereumPluginError =>
        ETHPluginException.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.eip4631Error =>
        EIP4631Exception.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.bcsError =>
        BcsSerializationException.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.solanaPlugin =>
        SolanaPluginException.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.solidityAbiError =>
        SolidityAbiException.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.suiPluginError =>
        DartSuiPluginException.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.tronPluginError =>
        TronPluginException.deserialize(object: decode.tag),
      _ => throw CborSerializableException.incorrectTagValue(),
    };
  }
  @override
  OnChainSerializationIdentifiers get serializationIdentifier;
}

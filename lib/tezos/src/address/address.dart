import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';

/// A Tezos address (`tz1`-`tz5` implicit, `KT1` contract, `sr1`/`epx1` rollup).
class TezosAddress with Equality, CborTagSerializable implements IAddress {
  /// Bech32-style Tezos address string.
  @override
  final String address;

  /// Address prefix (type).
  final XtzAddrPrefixes type;

  /// Raw 20-byte hash of the address.
  final BuBytes hashBytes;

  TezosAddress._(this.address, this.type, List<int> hashBytes)
    : hashBytes = hashBytes.asImmutableBytes;

  factory TezosAddress(String address, {XtzAddrPrefixes? type}) {
    try {
      final decode = XtzAddrDecoder().decode(address, addressPrefix: type);
      return TezosAddress._(address, decode.type, decode.bytes);
    } catch (e) {
      throw OnChainErrors.tezosAddress(
        'TezosAddress',
        reason: 'Invalid Tezos address.',
        details: {'address': address, 'error': e.toString()},
      );
    }
  }

  factory TezosAddress.fromBytes(List<int> bytes, {XtzAddrPrefixes? type}) {
    try {
      final encoded = XtzAddrEncoder().encode(bytes, addressPrefix: type);
      return TezosAddress._(encoded.address, encoded.type, encoded.hashBytes);
    } catch (e) {
      throw OnChainErrors.tezosAddress(
        'TezosAddress.fromBytes',
        reason: 'Invalid Tezos ${type?.name ?? 'unknown-type'} address bytes.',
        details: {'error': e.toString()},
      );
    }
  }
  factory TezosAddress.contractBytes(List<int> bytes) {
    return TezosAddress.fromBytes(bytes, type: XtzAddrPrefixes.kt1);
  }
  factory TezosAddress.smartRollupBytes(List<int> bytes) {
    return TezosAddress.fromBytes(bytes, type: XtzAddrPrefixes.sr1);
  }
  factory TezosAddress.zkRollupBytes(List<int> bytes) {
    return TezosAddress.fromBytes(bytes, type: XtzAddrPrefixes.epx1);
  }

  factory TezosAddress.fromPublickey({
    required List<int> publicKey,
    required TezosKeyType keyType,
  }) {
    try {
      final address = XtzAddrEncoder().encodeKey(
        publicKey,
        addressPrefix: keyType.addrType,
      );
      final decode = XtzAddrDecoder().decode(address);
      return TezosAddress._(address, decode.type, decode.bytes);
    } catch (e) {
      throw OnChainErrors.tezosAddress(
        'TezosAddress.fromPublickey',
        reason: 'Invalid ${keyType.name} public key.',
        details: {'error': e.toString()},
      );
    }
  }

  factory TezosAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tezos.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    final type = XtzAddrPrefixes.fromValue(values.rawValueAt(0));
    final addr = values.rawValueAt(1) as String;
    return TezosAddress(addr, type: type);
  }

  /// Implicit account address flag (`tz1`-`tz5`).
  bool get isImplicit => type.isImplicit;

  /// Originated contract flag (`KT1`).
  bool get isContract => type == XtzAddrPrefixes.kt1;

  /// Smart-rollup address flag (`sr1`).
  bool get isSmartRollup => type == XtzAddrPrefixes.sr1;

  /// Tagged PKH bytes for forge (`tag ‖ 20-byte hash`) — implicit only.
  List<int> toPublicKeyHashBytes() {
    final tag = type.pubKeyTag;
    if (tag == null) {
      throw OnChainErrors.tezosAddress(
        'toPublicKeyHashBytes',
        reason: 'Only tz1–tz5 have a public-key-hash wire form.',
        details: {'address': address, 'type': type.name},
      );
    }
    return [tag, ...hashBytes];
  }

  @override
  String toString() => address;

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.tezos;

  @override
  List<dynamic> get variables => [address];

  @override
  BuBytes encodeAsIAddress() => toCbor().encode();

  @override
  String? get viewType => type.name;

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject<Object?>?> get serializationItems => [
    type.value.toCbor(),
    address.toCbor(),
  ];
}

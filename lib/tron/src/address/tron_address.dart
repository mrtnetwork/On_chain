import 'package:on_chain/ethereum/src/address/evm_address.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

extension ExtToTronAddress on SolidityAddress {
  TronAddress toTronAddress() {
    if (this is TronAddress) return this as TronAddress;
    return TronAddress.fromEthAddress(toSolidtyBytes());
  }
}

/// Represents a Tron address.
class TronAddress extends SolidityAddress
    with CborTagSerializable, Equality
    implements IAddress {
  /// The Base58Check-encoded Tron address.
  @override
  final String address;

  /// Private constructor used internally.
  const TronAddress._(this.address, String hexAddress)
    : super.unsafe(hexAddress);

  static const TronAddress zero = TronAddress._(
    "T9yD14Nj9j7xAB4dbGeiX9h8unkKHxuWwb",
    "0000000000000000000000000000000000000000",
  );

  /// Creates a [TronAddress] from Tron public key bytes.
  factory TronAddress.fromPublicKey(List<int> keyBytes) {
    try {
      final toAddress = TrxAddrEncoder().encodeKey(keyBytes);
      final decode = TrxAddrDecoder().decodeAddr(toAddress);
      return TronAddress._(toAddress, BytesUtils.toHexString(decode));
    } catch (e) {
      throw BuError(
        OnChainErrorType.tronAddress,
        'Invalid Tron public key.',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  factory TronAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tron.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return TronAddress.fromBytes(values.rawValueAt(0));
  }

  /// Creates a [TronAddress] from a Base58Check or hex string.
  /// When [visible] is null the encoding is auto-detected.
  factory TronAddress(String address, {bool? visible}) {
    try {
      if (visible == null) {
        if (StringUtils.isHexBytes(address)) {
          return TronAddress.fromBytes(BytesUtils.fromHexString(address));
        }
        final decode = TrxAddrDecoder().decodeAddr(address);
        // print("hex ${BytesUtils.toHexString(decode)}");
        return TronAddress._(address, BytesUtils.toHexString(decode));
      } else {
        if (visible) {
          final decode = TrxAddrDecoder().decodeAddr(address);
          return TronAddress._(address, BytesUtils.toHexString(decode));
        } else {
          return TronAddress.fromBytes(BytesUtils.fromHexString(address));
        }
      }
    } catch (e) {
      throw BuError(
        OnChainErrorType.tronAddress,
        'Invalid Tron address.',
        details: {'input': address, 'visible': visible?.toString()},
      );
    }
  }

  /// Creates a [TronAddress] from 21-byte raw address bytes (0x41 prefix included).
  factory TronAddress.fromBytes(List<int> addrBytes) {
    if (addrBytes.length != lengthInBytes) {
      throw BuError(
        OnChainErrorType.tronAddress,
        "Invalid Tron address bytes length: expected 21.",
        details: {"length": addrBytes.length.toString()},
      );
    }
    final addr = TrxAddressUtils.fromHexBytes(addrBytes);
    return TronAddress._(addr, BytesUtils.toHexString(addrBytes.sublist(1)));
  }

  /// Creates a [TronAddress] from 20-byte EVM address bytes
  /// by prepending the Tron (0x41) prefix.
  factory TronAddress.fromEthAddress(List<int> addrBytes) {
    if (addrBytes.length != ETHAddress.lengthInBytes) {
      throw BuError(
        OnChainErrorType.tronAddress,
        "Invalid Tron EVM address bytes length: expected 20.",
        details: {"length": addrBytes.length.toString()},
      );
    }
    final addr = TrxAddressUtils.fromHexBytes([
      ...TrxAddressUtils.prefix,
      ...addrBytes,
    ]);
    return TronAddress._(addr, BytesUtils.toHexString(addrBytes));
  }

  BuBytes toBytes() {
    return BuBytes.unsafe([...TrxAddressUtils.prefix, ...toSolidtyBytes()]);
  }

  String toHex() => "41${StringUtils.normalizeHex(super.toSolidityHex())}";

  /// Returns the address as Base58Check when [visible] is true,
  /// otherwise as hex (0x41 prefix included).
  String toAddress([bool visible = true]) {
    if (visible) {
      return address;
    }
    return toHex();
  }

  /// Same as [toAddress].
  @override
  String toString([bool visible = true]) {
    return toAddress(visible);
  }

  /// Length of a raw Tron address in bytes (0x41 prefix included).
  static const int lengthInBytes = 21;

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.tron;

  @override
  BuBytes encodeAsIAddress() {
    return toCbor().encode().asImmutableBytes;
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [CborBytesValue(toBytes())];

  @override
  List<dynamic> get variables => [address];
}

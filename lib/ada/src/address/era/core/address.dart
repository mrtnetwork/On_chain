import 'package:blockchain_utils/bip/address/ada/ada_shelley_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/byron/byron.dart';
import 'package:on_chain/ada/src/address/era/shelly/shelly.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents an abstract class for ADA addresses with serialization capabilities.
abstract class ADAAddress with ADASerialization {
  /// Abstract property representing the ADA network.
  abstract final ADANetwork network;

  /// Abstract property representing the address string.
  abstract final String address;

  /// Abstract property representing the type of ADA address.
  abstract final ADAAddressType addressType;

  /// Abstract property representing the Bech32 address.
  abstract final String bech32Address;

  bool get isRewardAddress => addressType == ADAAddressType.reward;
  bool get isByron => addressType == ADAAddressType.byron;

  /// Default constructor for ADAAddress.
  const ADAAddress.init();

  /// Factory method to create an ADAAddress instance from a given address string.
  static T fromAddress<T extends ADAAddress>(String address,
      {ADANetwork? network}) {
    final type = AdaAddressUtils.findAddrType(address);
    final ADAAddress addr;
    switch (type) {
      case ADAAddressType.base:
        addr = ADABaseAddress(address, network: network);
        break;
      case ADAAddressType.pointer:
        addr = ADAPointerAddress(address, network: network);
        break;
      case ADAAddressType.reward:
        addr = ADARewardAddress(address, network: network);
        break;
      case ADAAddressType.enterprise:
        addr = ADAEnterpriseAddress(address, network: network);
        break;
      default:
        addr = ADAByronAddress(address, network: network);
        break;
    }
    if (addr is! T) {
      throw ADAPluginException('Invalid address type.', details: {
        'expected': '$T',
        'Type': addr.runtimeType,
        'address': addr.address
      });
    }
    return addr;
  }

  /// Factory method to create an ADAAddress instance from bytes.
  static T fromRawBytes<T extends ADAAddress>(List<int> bytes,
      {ADANetwork? network}) {
    return _deserialize<T>(bytes, network: network);
  }

  /// Factory method to create an ADAAddress instance from cbor bytes.
  static T fromBytes<T extends ADAAddress>(List<int> bytes,
      {ADANetwork? network}) {
    return deserialize<T>(
        CborObject.fromCbor(bytes).as<CborBytesValue>('ADAAddress'),
        network: network);
  }

  /// Deserializes a CBOR object into an ADAAddress instance.
  static T deserialize<T extends ADAAddress>(CborBytesValue cbor,
      {ADANetwork? network}) {
    return _deserialize(cbor.value, network: network);
  }

  //  /// Deserializes a CBOR object into an ADAAddress instance.
  static T _deserialize<T extends ADAAddress>(List<int> bytes,
      {ADANetwork? network}) {
    ADAAddress address;
    try {
      address = ADAByronAddress.fromRawBytes(bytes);
    } catch (e) {
      address = ADAAddress.fromAddress(AdaShelleyAddrUtils.encodeBytes(bytes));
    }
    if (address is! T) {
      throw ADAPluginException('Invalid ADA address type.', details: {
        'expected': '$T',
        'Type': address.addressType,
        'address': address.address
      });
    }
    if (network != null && address.network != network) {
      throw ADAPluginException('Invalid network.',
          details: {'expected': network.name, 'network': address.network.name});
    }
    return address;
  }

  /// Returns the string representation of the ADAAddress.
  @override
  String toString() {
    return address;
  }

  List<int> toBytes();

  /// Converts the ADAAddress instance to JSON.
  @override
  String toJson() {
    return address;
  }

  T cast<T extends ADAAddress>() {
    if (this is! T) {
      throw ADAPluginException('ADAAddress casting failed.',
          details: {'expected': '$T', 'type': addressType.name});
    }
    return this as T;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ADAAddress &&
            other.runtimeType == runtimeType &&
            address == other.address);
  }

  @override
  int get hashCode =>
      address.hashCode ^ addressType.hashCode ^ network.hashCode;
}

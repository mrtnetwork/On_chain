import 'package:blockchain_utils/bip/address/ada/ada_shelley_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/byron/byron.dart';
import 'package:on_chain/ada/src/address/era/shelly/shelly.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
/// Represents an abstract class for ADA addresses with serialization capabilities.
abstract class ADAAddress with ADASerialization {
  /// Abstract property representing the ADA network.
  abstract final AdaNetwork network;

  /// Abstract property representing the address string.
  abstract final String address;

  /// Abstract property representing the type of ADA address.
  abstract final AdaAddressType addressType;

  /// Abstract property representing the Bech32 address.
  abstract final String bech32Address;

  /// Default constructor for ADAAddress.
  const ADAAddress.init();

  /// Factory method to create an ADAAddress instance from a given address string.
  static T fromAddress<T extends ADAAddress>(String address,
      {AdaNetwork? network}) {
    final type = AdaAddressUtils.findAddrType(address);
    final ADAAddress addr;
    switch (type) {
      case AdaAddressType.base:
        addr = ADABaseAddress(address, network: network);
        break;
      case AdaAddressType.pointer:
        addr = ADAPointerAddress(address, network: network);
        break;
      case AdaAddressType.reward:
        addr = ADARewardAddress(address, network: network);
        break;
      case AdaAddressType.enterprise:
        addr = ADAEnterpriseAddress(address, network: network);
        break;
      default:
        addr = ADAByronAddress(address, network: network);
        break;
    }
    if (addr is! T) {
      throw MessageException("Invalid address type.", details: {
        "Excepted": "$T",
        "Type": addr.runtimeType,
        "address": addr.address
      });
    }
    return addr;
  }

  /// Factory method to create an ADAAddress instance from bytes.
  static T fromBytes<T extends ADAAddress>(List<int> bytes) {
    return deserialize<T>(CborObject.fromCbor(bytes).cast());
  }

  /// Deserializes a CBOR object into an ADAAddress instance.
  static T deserialize<T extends ADAAddress>(CborBytesValue cbor) {
    ADAAddress address;
    try {
      CborObject.fromCbor(cbor.value).cast();
      address = ADAByronAddress.deserialize(cbor);
    } catch (e) {
      address =
          ADAAddress.fromAddress(AdaShelleyAddrUtils.encodeBytes(cbor.value));
    }

    if (address is! T) {
      throw MessageException("Invalid ADA address type.", details: {
        "Excepted": "$T",
        "Type": address.addressType,
        "address": address.address
      });
    }
    return address;
  }


  /// Returns the string representation of the ADAAddress.
  @override
  String toString() {
    return address;
  }

  /// Converts the ADAAddress instance to JSON.
  @override
  String toJson() {
    return address;
  }
}

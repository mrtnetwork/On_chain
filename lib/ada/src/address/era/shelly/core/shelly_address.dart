import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/era/shelly/shelly.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';

/// Represents an abstract class for Shelley addresses, a subtype of ADAAddress.
abstract class ADAShellyAddress extends ADAAddress {
  /// Returns the Bech32 representation of the address, which is the address itself.
  @override
  String get bech32Address => address;

  /// Abstract property representing the payment credential of the address.
  abstract final StakeCred paymentCredential;

  /// Constructor for ADAShellyAddress.
  const ADAShellyAddress.init() : super.init();

  /// Factory method to create an ADAShellyAddress instance from a given address string.
  factory ADAShellyAddress.fromAddress(String address, {ADANetwork? network}) {
    final type = AdaAddressUtils.findAddrType(address);
    switch (type) {
      case ADAAddressType.base:
        return ADABaseAddress(address, network: network);
      case ADAAddressType.pointer:
        return ADAPointerAddress(address, network: network);
      case ADAAddressType.reward:
        return ADARewardAddress(address, network: network);
      case ADAAddressType.enterprise:
        return ADAEnterpriseAddress(address, network: network);
      default:
        throw MessageException(
            "Invalid shelly address. for byron address please use ByronAddress.");
    }
  }

  /// Factory method to create an ADAShellyAddress instance from bytes.
  static T fromBytes<T extends ADAShellyAddress>(List<int> bytes) {
    return deserialize<T>(CborObject.fromCbor(bytes).cast());
  }

  /// Deserializes a CBOR object into an ADAShellyAddress instance.
  static T deserialize<T extends ADAShellyAddress>(CborBytesValue cbor) {
    ADAAddress address = ADAAddress.deserialize(cbor);
    if (address is! T) {
      throw MessageException("Invalid address type.", details: {
        "Excepted": "$T",
        "Type": address.runtimeType,
        "address": address.address
      });
    }
    return address;
  }

  /// Converts the ADAAddress instance to CBOR.
  @override
  CborObject toCbor() {
    return CborBytesValue(
        AdaAddressUtils.decodeShellyAddress(address, keepPrefix: true));
  }
}

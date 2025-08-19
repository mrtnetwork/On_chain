import 'package:blockchain_utils/bip/address/ada/ada_shelley_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/era/shelly/shelly.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents an abstract class for Shelley addresses, a subtype of ADAAddress.
abstract class ADAShellyAddress extends ADAAddress {
  /// Returns the Bech32 representation of the address, which is the address itself.
  @override
  String get bech32Address => address;

  /// Abstract property representing the payment credential of the address.
  abstract final Credential paymentCredential;

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
        throw const ADAPluginException(
            'Invalid shelly address. for byron address please use ByronAddress.');
    }
  }

  static T fromRawBytes<T extends ADAShellyAddress>(List<int> bytes) {
    return _deserialize<T>(bytes);
  }

  /// Factory method to create an ADAShellyAddress instance from cbor bytes.
  static T fromBytes<T extends ADAShellyAddress>(List<int> bytes) {
    return deserialize<T>(
        CborObject.fromCbor(bytes).as<CborBytesValue>("ADAShellyAddress"));
  }

  /// Deserializes a CBOR object into an ADAShellyAddress instance.
  static T deserialize<T extends ADAShellyAddress>(CborBytesValue cbor) {
    return _deserialize<T>(cbor.value);
  }

  /// Deserializes a CBOR object into an ADAShellyAddress instance.
  static T _deserialize<T extends ADAShellyAddress>(List<int> bytes,
      {ADANetwork? network}) {
    final address =
        ADAAddress.fromAddress(AdaShelleyAddrUtils.encodeBytes(bytes));
    if (address is! T) {
      throw ADAPluginException('Invalid address type.', details: {
        'expected': '$T',
        'Type': address.runtimeType,
        'address': address.address
      });
    }
    if (network != null && address.network != network) {
      throw ADAPluginException('Invalid network.',
          details: {'expected': network.name, 'network': address.network.name});
    }
    return address;
  }

  /// Converts the ADAAddress instance to CBOR.
  @override
  CborObject toCbor() {
    return CborBytesValue(
        AdaAddressUtils.decodeShellyAddress(address, keepPrefix: true));
  }

  @override
  List<int> toBytes() {
    return AdaAddressUtils.decodeShellyAddress(address, keepPrefix: true);
  }
}

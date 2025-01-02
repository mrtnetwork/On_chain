import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/shelly/core/shelly_address.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';

/// Represents an ADA pointer address, a subtype of ADAShellyAddress.
class ADAPointerAddress extends ADAShellyAddress {
  /// The payment credential associated with the address.
  @override
  final StakeCred paymentCredential;

  /// The pointer associated with the address.
  final Pointer pointer;

  /// The address string.
  @override
  final String address;

  /// The ADA network associated with the address.
  @override
  final ADANetwork network;
  @override
  ADAAddressType get addressType => ADAAddressType.pointer;

  /// Constructor for ADAPointerAddress.
  const ADAPointerAddress._({
    required this.paymentCredential,
    required this.pointer,
    required this.address,
    required this.network,
  }) : super.init();

  /// Factory method to create an ADAPointerAddress instance from a given address string.
  factory ADAPointerAddress(String address, {ADANetwork? network}) {
    final decode = AdaAddressUtils.decodeAddres(address,
        network: network, addrType: ADAAddressType.pointer);
    return ADAPointerAddress._(
        paymentCredential: AdaAddressUtils.toCerdential(decode.baseHashBytes!),
        pointer: decode.pointer!,
        address: address,
        network: decode.network);
  }

  /// Factory constructor to create an ADAPointerAddress instance from a payment credential and a pointer.
  factory ADAPointerAddress.fromCredential(
      {required StakeCred paymentCredential,
      required Pointer pointer,
      ADANetwork network = ADANetwork.mainnet}) {
    final encode = AdaPointerAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(paymentCredential),
        {'pointer': pointer, 'net_tag': network});
    return ADAPointerAddress._(
        paymentCredential: paymentCredential,
        pointer: pointer,
        address: encode,
        network: network);
  }

  /// Factory constructor to create an ADAPointerAddress instance from a public key and a pointer.
  factory ADAPointerAddress.fromPublicKey(
      {required List<int> pubkeyBytes,
      required Pointer pointer,
      ADANetwork network = ADANetwork.mainnet}) {
    final credential = AdaAddressUtils.publicKeyToCredential(pubkeyBytes);
    final encode = AdaPointerAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        {'pointer': pointer, 'net_tag': network});
    return ADAPointerAddress._(
        paymentCredential: credential,
        pointer: pointer,
        address: encode,
        network: network);
  }

  /// Factory constructor to create an ADAPointerAddress instance from a Bip32 structure and a pointer.
  factory ADAPointerAddress.fromBip32(
      {required CardanoByronLegacyBip32 bip32,
      required Pointer pointer,
      ADANetwork network = ADANetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(bip32.publicKey.compressed);
    final encode = AdaPointerAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        {'pointer': pointer, 'net_tag': network});
    return ADAPointerAddress._(
        paymentCredential: credential,
        pointer: pointer,
        address: encode,
        network: network);
  }

  /// Factory constructor to create an ADAPointerAddress instance from an Icarus structure and a pointer.
  factory ADAPointerAddress.fromIcarus(
      {required CardanoIcarusBip32 bip32,
      required Pointer pointer,
      ADANetwork network = ADANetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(bip32.publicKey.compressed);
    final encode = AdaPointerAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        {'pointer': pointer, 'net_tag': network});
    return ADAPointerAddress._(
        paymentCredential: credential,
        pointer: pointer,
        address: encode,
        network: network);
  }

  /// Factory constructor to create an ADAPointerAddress instance from a CIP1852 structure and a pointer.
  factory ADAPointerAddress.fromCip1852(
      {required Cip1852 cip1585,
      required Pointer pointer,
      ADANetwork network = ADANetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(cip1585.publicKey.compressed);
    final encode = AdaPointerAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        {'pointer': pointer, 'net_tag': network});
    return ADAPointerAddress._(
        paymentCredential: credential,
        pointer: pointer,
        address: encode,
        network: network);
  }
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/shelly/core/shelly_address.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

/// Represents an ADA reward address, a subtype of ADAShellyAddress.
class ADARewardAddress extends ADAShellyAddress {
  /// The payment credential associated with the address.
  @override
  final Credential paymentCredential;

  /// The address string.
  @override
  final String address;

  /// The ADA network associated with the address.
  @override
  final ADANetwork network;
  @override
  ADAAddressType get addressType => ADAAddressType.reward;

  /// Constructor for ADARewardAddress.
  const ADARewardAddress._(
      {required this.paymentCredential,
      required this.address,
      required this.network})
      : super.init();

  /// Factory method to create an ADARewardAddress instance from a given address string.
  factory ADARewardAddress(String address, {ADANetwork? network}) {
    final decode = AdaAddressUtils.decodeAddres(address,
        addrType: ADAAddressType.reward, network: network);
    return ADARewardAddress._(
        paymentCredential: AdaAddressUtils.toCerdential(decode.baseHashBytes!),
        address: address,
        network: decode.network);
  }

  /// Factory method to create an ADARewardAddress instance from a payment credential.
  factory ADARewardAddress.fromCredential(
      {required Credential credential,
      ADANetwork network = ADANetwork.mainnet}) {
    final encode = AdaShelleyStakingAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        network: network);
    return ADARewardAddress._(
        paymentCredential: credential, address: encode, network: network);
  }

  /// Factory method to create an ADARewardAddress instance from a public key.
  factory ADARewardAddress.fromPublicKey(
      {required List<int> pubkeyBytes,
      ADANetwork network = ADANetwork.mainnet}) {
    final credential = AdaAddressUtils.publicKeyToCredential(pubkeyBytes);
    final encode = AdaShelleyStakingAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        network: network);
    return ADARewardAddress._(
        paymentCredential: credential, address: encode, network: network);
  }

  /// Factory method to create an ADARewardAddress instance from a Bip32 structure.
  factory ADARewardAddress.fromBip32(
      {required CardanoByronLegacyBip32 bip32,
      ADANetwork network = ADANetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(bip32.publicKey.compressed);
    final encode = AdaShelleyStakingAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        network: network);
    return ADARewardAddress._(
        paymentCredential: credential, address: encode, network: network);
  }

  /// Factory method to create an ADARewardAddress instance from an Icarus structure.
  factory ADARewardAddress.fromIcarus(
      {required CardanoIcarusBip32 bip32,
      ADANetwork network = ADANetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(bip32.publicKey.compressed);
    final encode = AdaShelleyStakingAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        network: network);
    return ADARewardAddress._(
        paymentCredential: credential, address: encode, network: network);
  }

  /// Factory method to create an ADARewardAddress instance from a CIP1852 structure.
  factory ADARewardAddress.fromCip1852(
      {required Cip1852 cip1582, ADANetwork network = ADANetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(cip1582.publicKey.compressed);
    final encode = AdaShelleyStakingAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential),
        network: network);
    return ADARewardAddress._(
        paymentCredential: credential, address: encode, network: network);
  }
}

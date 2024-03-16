import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';

class ADAEnterpriseAddress extends ADAShellyAddress {
  @override
  final StakeCred paymentCredential;
  @override
  final String address;
  @override
  final AdaNetwork network;

  @override
  AdaAddressType get addressType => AdaAddressType.enterprise;
  const ADAEnterpriseAddress._(
      {required this.paymentCredential,
      required this.address,
      required this.network})
      : super.init();

  factory ADAEnterpriseAddress(String address, {AdaNetwork? network}) {
    final decode = AdaAddressUtils.decodeAddres(address,
        addrType: AdaAddressType.enterprise, network: network);
    return ADAEnterpriseAddress._(
        paymentCredential: AdaAddressUtils.toCerdential(decode.baseHashBytes!),
        address: address,
        network: decode.network);
  }
  factory ADAEnterpriseAddress.fromCredential(
      {required StakeCred credential,
      AdaNetwork network = AdaNetwork.mainnet}) {
    final encode = AdaShelleyEnterpriseAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential), {"net_tag": network});
    return ADAEnterpriseAddress._(
        paymentCredential: credential, address: encode, network: network);
  }
  factory ADAEnterpriseAddress.fromPublicKey(
      {required List<int> pubkeyBytes,
      AdaNetwork network = AdaNetwork.mainnet}) {
    final credential = AdaAddressUtils.publicKeyToCredential(pubkeyBytes);
    final encode = AdaShelleyEnterpriseAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential), {"net_tag": network});
    return ADAEnterpriseAddress._(
        paymentCredential: credential, address: encode, network: network);
  }
  factory ADAEnterpriseAddress.fromBip32(
      {required CardanoByronLegacyBip32 bip32,
      AdaNetwork network = AdaNetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(bip32.publicKey.compressed);
    final encode = AdaShelleyEnterpriseAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential), {"net_tag": network});
    return ADAEnterpriseAddress._(
        paymentCredential: credential, address: encode, network: network);
  }
  factory ADAEnterpriseAddress.fromIcarus(
      {required CardanoIcarusBip32 bip32,
      AdaNetwork network = AdaNetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(bip32.publicKey.compressed);
    final encode = AdaShelleyEnterpriseAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential), {"net_tag": network});
    return ADAEnterpriseAddress._(
        paymentCredential: credential, address: encode, network: network);
  }
  factory ADAEnterpriseAddress.fromCip1852(
      {required Cip1852 cip1852, AdaNetwork network = AdaNetwork.mainnet}) {
    final credential =
        AdaAddressUtils.publicKeyToCredential(cip1852.publicKey.compressed);
    final encode = AdaShelleyEnterpriseAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(credential), {"net_tag": network});
    return ADAEnterpriseAddress._(
        paymentCredential: credential, address: encode, network: network);
  }
}

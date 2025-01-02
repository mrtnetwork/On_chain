import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/shelly/core/shelly_address.dart';
import 'package:on_chain/ada/src/address/era/shelly/enterprise_address.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';
import 'ada_reward_address.dart';

/// Represents an ADA base address, a subtype of ADAShellyAddress.
class ADABaseAddress extends ADAShellyAddress {
  /// The payment credential associated with the address.
  @override
  final StakeCred paymentCredential;

  /// The stake credential associated with the address.
  final StakeCred stakeCredential;

  /// The address string.
  @override
  final String address;

  /// The ADA network associated with the address.
  @override
  final ADANetwork network;

  @override
  ADAAddressType get addressType => ADAAddressType.base;

  const ADABaseAddress._(
      {required this.paymentCredential,
      required this.stakeCredential,
      required this.address,
      required this.network})
      : super.init();

  /// Factory method to create an ADABaseAddress instance from a given address string.
  factory ADABaseAddress(String address, {ADANetwork? network}) {
    final decode = AdaAddressUtils.decodeAddres(address,
        addrType: ADAAddressType.base, network: network);
    return ADABaseAddress._(
        paymentCredential: AdaAddressUtils.toCerdential(decode.baseHashBytes!),
        stakeCredential: AdaAddressUtils.toCerdential(decode.stakeHashBytes!),
        address: address,
        network: decode.network);
  }

  /// Factory method to create an ADABaseAddress instance from payment and stake credentials.
  factory ADABaseAddress.fromCredential(
      {required StakeCred baseCredential,
      required StakeCred stakeCredential,
      ADANetwork network = ADANetwork.mainnet}) {
    final encode = AdaShelleyAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(baseCredential), {
      'net_tag': network,
      'pub_skey': AdaAddressUtils.toAdaStakeCredential(stakeCredential)
    });
    return ADABaseAddress._(
        paymentCredential: baseCredential,
        address: encode,
        stakeCredential: stakeCredential,
        network: network);
  }

  /// Factory method to create an ADABaseAddress instance from base and stake public keys.
  factory ADABaseAddress.fromPublicKey(
      {required List<int> basePubkeyBytes,
      required List<int> stakePubkeyBytes,
      ADANetwork network = ADANetwork.mainnet}) {
    final baseCredential =
        AdaAddressUtils.publicKeyToCredential(basePubkeyBytes);
    final stakeCredential =
        AdaAddressUtils.publicKeyToCredential(stakePubkeyBytes);
    final encode = AdaShelleyAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(baseCredential), {
      'net_tag': network,
      'pub_skey': AdaAddressUtils.toAdaStakeCredential(stakeCredential)
    });
    return ADABaseAddress._(
        paymentCredential: baseCredential,
        stakeCredential: stakeCredential,
        address: encode,
        network: network);
  }

  /// Factory method to create an ADABaseAddress instance from a Shelley wallet.
  factory ADABaseAddress.shellyWallet(
      {required CardanoShelley shelleyWallet,
      ADANetwork network = ADANetwork.mainnet}) {
    final baseCredential = AdaAddressUtils.publicKeyToCredential(
        shelleyWallet.bip44.publicKey.compressed);
    final stakeCredential = AdaAddressUtils.publicKeyToCredential(
        shelleyWallet.bip44Sk.publicKey.compressed);
    final encode = AdaShelleyAddrEncoder().encodeCredential(
        AdaAddressUtils.toAdaStakeCredential(baseCredential), {
      'net_tag': network,
      'pub_skey': AdaAddressUtils.toAdaStakeCredential(stakeCredential)
    });
    return ADABaseAddress._(
        paymentCredential: baseCredential,
        stakeCredential: stakeCredential,
        address: encode,
        network: network);
  }

  /// Get the stake address associated with the base address.
  ADARewardAddress stakeAddress() => ADARewardAddress.fromCredential(
      credential: stakeCredential, network: network);

  /// Get the enterprise address associated with the base address.
  ADAEnterpriseAddress enterpriseAddress() =>
      ADAEnterpriseAddress.fromCredential(
          credential: paymentCredential, network: network);
}

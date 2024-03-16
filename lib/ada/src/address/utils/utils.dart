import 'package:blockchain_utils/bip/address/ada/ada.dart';
import 'package:blockchain_utils/bip/address/addr_key_validator.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred_type.dart';
import 'package:on_chain/ada/src/models/credential/key.dart';
import 'package:on_chain/ada/src/models/credential/script.dart';

/// Utility class for handling ADA addresses.
class AdaAddressUtils {
  /// Decode an ADA address string.
  ///
  /// [address]: The address to decode.
  /// [addrType]: The expected address type. If provided, the decoded address type
  /// must match this.
  /// [network]: The network type.
  ///
  /// Returns a [AdaGenericAddrDecoderResult] object containing the decoded address.
  static AdaGenericAddrDecoderResult decodeAddres(String address,
      {AdaAddressType? addrType, AdaNetwork? network}) {
    final decodeAddr =
        AdaGenericAddrDecoder().decode(address, {"net_tag": network});
    if (addrType != null) {
      if (decodeAddr.type.header != addrType.header) {
        throw MessageException("Incorrect address type. ",
            details: {"Excepted": addrType.name, "type": decodeAddr.type});
      }
    }
    return decodeAddr;
  }

  /// Encode a byte list to an ADA address.
  ///
  /// [addrBytes]: The byte list to encode.
  ///
  /// Returns an [ADAAddress] object.
  static ADAAddress encodeBytes(List<int> addrBytes) {
    try {
      final byron = AdaByronAddr.deserialize(addrBytes).encode();
      return ADAAddress.fromAddress(byron);
    } catch (e) {
      return ADAAddress.fromAddress(AdaShelleyAddrUtils.encodeBytes(addrBytes));
    }
  }

  /// Decode an ADA Shelly address string to bytes.
  ///
  /// [address]: The address to decode.
  /// [network]: The network type.
  /// [keepPrefix]: Whether to keep the address prefix.
  ///
  /// Returns a byte list representing the decoded address.
  static List<int> decodeShellyAddress(
    String address, {
    AdaNetwork? network,
    bool keepPrefix = true,
  }) {
    final decode =
        AdaGenericAddrDecoder().decode(address, {"net_tag": network});
    if (decode.type == AdaAddressType.byron) {
      throw MessageException("Invalid shelly address.",
          details: {"address": address, "type": decode.type});
    }
    if (keepPrefix) {
      return decode.addressBytes;
    }
    return decode.addressBytes.sublist(decode.prefixBytes!.length);
  }

  /// Convert an [AdaStakeCredential] to a [StakeCred].
  ///
  /// [credential]: The [AdaStakeCredential] to convert.
  ///
  /// Returns a [StakeCred] object.
  static StakeCred toCerdential(AdaStakeCredential credential) {
    if (credential.type == AdaStakeCredType.key) {
      return StakeCredKey(credential.hash);
    }
    return StakeCredScript(credential.hash);
  }

  /// Convert a [StakeCred] to an [AdaStakeCredential].
  ///
  /// [credential]: The [StakeCred] to convert.
  ///
  /// Returns an [AdaStakeCredential] object.
  static AdaStakeCredential toAdaStakeCredential(StakeCred credential) {
    if (credential.type == StakeCredType.key) {
      return AdaStakeCredential(
          hash: credential.data, type: AdaStakeCredType.key);
    }
    return AdaStakeCredential(
        hash: credential.data, type: AdaStakeCredType.script);
  }

  /// Convert a public key byte list to a [StakeCredKey].
  ///
  /// [pubKeyBytes]: The public key byte list.
  ///
  /// Returns a [StakeCredKey] object.
  static StakeCredKey publicKeyToCredential(List<int> pubKeyBytes) {
    return StakeCredKey(publicKeyToHash(pubKeyBytes));
  }

  /// Convert a public key byte list to a hash byte list.
  ///
  /// [pubKeyBytes]: The public key byte list.
  ///
  /// Returns a hash byte list.
  static List<int> publicKeyToHash(List<int> pubKeyBytes) {
    final pubKeyObj = AddrKeyValidator.validateAndGetEd25519Key(pubKeyBytes);
    return QuickCrypto.blake2b224Hash(pubKeyObj.compressed.sublist(1));
  }

  /// Validate a public key byte list and remove prefix if present.
  ///
  /// [pubKeyBytes]: The public key byte list to validate and remove prefix from.
  ///
  /// Returns the validated public key byte list without the prefix
  static List<int> validatePubkeyAndRemovePrefix(List<int> pubKeyBytes) {
    final pubKeyObj = AddrKeyValidator.validateAndGetEd25519Key(pubKeyBytes);
    return pubKeyObj.compressed.sublist(1);
  }

  /// Find the address type of a given ADA address.
  ///
  /// [addr]: The ADA address.
  ///
  /// Returns the [AdaAddressType] of the address.
  static AdaAddressType findAddrType(String addr) {
    final decodeAddr = AdaGenericAddrDecoder().decode(addr);
    return decodeAddr.type;
  }

  static const String _poolIdHrp = "pool";

  /// Decode a Bech32-encoded pool ID string to bytes.
  ///
  /// [bech32PoolId]: The Bech32-encoded pool ID.
  ///
  /// Returns a byte list representing the decoded pool ID.
  static List<int> decodePoolIdBech32(String bech32PoolId) {
    final poolId = Bech32Decoder.decode(_poolIdHrp, bech32PoolId);
    return poolId;
  }
}

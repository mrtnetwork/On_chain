import 'package:blockchain_utils/bip/address/ada/ada.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents an ADA Byron address, a subtype of ADAAddres
class ADAByronAddress extends ADAAddress {
  /// The address string. (base58)
  @override
  final String address;

  /// Bech32 representation of the address.
  @override
  String get bech32Address => extendedAddress.toBech32();

  /// Extended address containing additional information.
  final ADAByronAddr extendedAddress;

  /// The ADA network associated with this address.
  @override
  final ADANetwork network;

  /// Constructor for ADAByronAddress.
  const ADAByronAddress._(this.address, this.extendedAddress, this.network)
      : super.init();

  /// Factory constructor to create an ADAByronAddress instance from a given address string.
  factory ADAByronAddress(String address, {ADANetwork? network}) {
    final decode = AdaAddressUtils.decodeAddres(address,
        addrType: ADAAddressType.byron, network: network);
    return ADAByronAddress._(decode.byronAddrPayload!.encode(),
        decode.byronAddrPayload!, decode.network);
  }

  /// Factory constructor to create an ADAByronAddress instance from a public key and chaincode.
  factory ADAByronAddress.fromPublicKey(
      {required List<int> publicKey,
      required List<int> chaincode,
      List<int>? hdPathKey,
      String? hdPath,
      ADANetwork network = ADANetwork.mainnet}) {
    if (hdPath != null && hdPathKey != null) {
      return ADAByronAddress.legacy(
          publicKey: publicKey,
          chaincode: chaincode,
          hdPathKey: hdPathKey,
          hdPath: hdPath,
          network: network);
    }
    final encode = AdaByronIcarusAddrEncoder().encodeKeyWithInfo(
        publicKey, {'net_tag': network, 'chain_code': chaincode});
    return ADAByronAddress._(encode.encode(), encode, network);
  }

  /// Factory constructor to create an ADAByronAddress instance from a Bip32 structure.
  factory ADAByronAddress.fromBip32(
      {required CardanoByronLegacyBip32 bip32,
      ADANetwork network = ADANetwork.mainnet}) {
    final encode = AdaByronIcarusAddrEncoder().encodeKeyWithInfo(
        bip32.publicKey.compressed, {
      'net_tag': network,
      'chain_code': bip32.publicKey.chainCode.toBytes()
    });
    return ADAByronAddress._(encode.encode(), encode, network);
  }

  /// Factory constructor to create an ADAByronAddress instance from an Icarus structure.
  factory ADAByronAddress.fromIcarus(
      {required CardanoIcarusBip32 bip32,
      ADANetwork network = ADANetwork.mainnet}) {
    final encode = AdaByronIcarusAddrEncoder().encodeKeyWithInfo(
        bip32.publicKey.compressed, {
      'net_tag': network,
      'chain_code': bip32.publicKey.chainCode.toBytes()
    });
    return ADAByronAddress._(encode.encode(), encode, network);
  }

  /// Factory constructor to create a legacy ADAByronAddress instance from a Bip32 structure.
  factory ADAByronAddress.legacyFromBip32(
      {required CardanoByronLegacy bip32,
      required Bip32KeyIndex firstIndex,
      required Bip32KeyIndex secondIndex,
      ADANetwork network = ADANetwork.mainnet}) {
    final publicKey =
        bip32.getPublicKey(firstIndex: firstIndex, secondIndex: secondIndex);
    final encode = AdaByronLegacyAddrEncoder()
        .encodeKeyWithInfo(publicKey.pubKey.compressed, {
      'net_tag': network,
      'chain_code': publicKey.chainCode.toBytes(),
      'hd_path': 'm/${firstIndex.toInt()}\'/${secondIndex.toInt()}\'',
      'hd_path_key': bip32.hdPathKey
    });
    return ADAByronAddress._(encode.encode(), encode, network);
  }

  /// Factory constructor to create a legacy ADAByronAddress instance.
  factory ADAByronAddress.legacy(
      {required List<int> publicKey,
      required List<int> chaincode,
      required List<int> hdPathKey,
      required String hdPath,
      ADANetwork network = ADANetwork.mainnet}) {
    final encode = AdaByronLegacyAddrEncoder().encodeKeyWithInfo(publicKey, {
      'net_tag': network,
      'chain_code': chaincode,
      'hd_path': hdPath,
      'hd_path_key': hdPathKey
    });
    return ADAByronAddress._(encode.encode(), encode, network);
  }

  /// Factory method to create an ADAByronAddress instance from bytes.
  factory ADAByronAddress.fromBytes(List<int> bytes) {
    return ADAByronAddress.deserialize(CborObject.fromCbor(bytes).cast());
  }

  /// Deserializes a CBOR object into an ADAByronAddress instance.
  static ADAByronAddress deserialize(CborBytesValue cbor,
      {ADANetwork? network}) {
    final cborList = CborObject.fromCbor(cbor.value).cast();
    final addr = ADAByronAddr.deserialize(cborList.encode());
    return ADAByronAddress(addr.encode(), network: network);
  }

  /// Converts the ADAByronAddress instance to CBOR.
  @override
  CborObject toCbor() {
    return CborBytesValue(extendedAddress.toCbor().encode());
  }

  /// Serializes the attributes of the extended address.
  List<int> attributeSerialize() {
    return CborMapValue.fixedLength(extendedAddress.payload.attrs.toJson())
        .encode();
  }

  /// Returns the address type, which is ADAAddressType.byron.
  @override
  ADAAddressType get addressType => ADAAddressType.byron;
}

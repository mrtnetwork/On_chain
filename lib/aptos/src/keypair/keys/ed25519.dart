import 'package:blockchain_utils/bip/address/aptos_addr.dart';
import 'package:blockchain_utils/bip/ecc/keys/ed25519_keys.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:blockchain_utils/signer/signer.dart';
import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/aptos/src/account/account.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/aptos/src/keypair/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosED25519PrivateKey extends AptosBasePrivateKey<AptosED25519PublicKey,
    AptosEd25519AnySignature> {
  final Ed25519PrivateKey _privateKey;
  AptosED25519PrivateKey._(this._privateKey)
      : super(algorithm: AptosKeyAlgorithm.ed25519);
  factory AptosED25519PrivateKey.fromBytes(List<int> keyBytes) {
    return AptosED25519PrivateKey._(Ed25519PrivateKey.fromBytes(keyBytes));
  }

  @override
  late final AptosED25519PublicKey publicKey =
      AptosED25519PublicKey._(_privateKey.publicKey);

  @override
  AptosEd25519AnySignature sign(List<int> digest) {
    final signer = Ed25519Signer.fromKeyBytes(toBytes());
    return AptosEd25519AnySignature(signer.signConst(digest));
  }

  @override
  List<int> toBytes() {
    return _privateKey.raw;
  }

  @override
  String toHex({bool lowerCase = true, String prefix = ''}) {
    return _privateKey.toHex(lowerCase: lowerCase, prefix: prefix);
  }
}

class AptosED25519PublicKey extends AptosCryptoPublicKey<Ed25519PublicKey> {
  const AptosED25519PublicKey._(Ed25519PublicKey publicKey)
      : super(algorithm: AptosKeyAlgorithm.ed25519, publicKey: publicKey);
  factory AptosED25519PublicKey.fromBytes(List<int> keyBytes) {
    return AptosED25519PublicKey._(Ed25519PublicKey.fromBytes(keyBytes));
  }
  factory AptosED25519PublicKey.fromStruct(Map<String, dynamic> json) {
    return AptosED25519PublicKey.fromBytes(json.asBytes("key"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: "key"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"key": publicKeyBytes()};
  }

  @override
  @override
  List<int> publicKeyBytes() {
    return publicKey.compressed.sublist(1);
  }

  @override
  String publicKeyHex({bool lowerCase = false}) {
    return BytesUtils.toHexString(publicKeyBytes(), lowerCase: lowerCase);
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosED25519PublicKey) return false;
    return publicKey == other.publicKey;
  }

  @override
  int get hashCode => publicKey.hashCode;

  @override
  bool verify({required List<int> message, required List<int> signature}) {
    final verifier = Ed25519Verifier.fromKeyBytes(publicKeyBytes());
    return verifier.verify(message, signature);
  }

  @override
  AptosAddress toAddress(
      {AptosEd25519AddressScheme scheme = AptosEd25519AddressScheme.ed25519}) {
    return switch (scheme) {
      AptosEd25519AddressScheme.ed25519 =>
        AptosAddress(AptosAddrEncoder().encodeKey(publicKey.compressed)),
      AptosEd25519AddressScheme.signleKey =>
        AptosAddress(AptosAddrEncoder().encodeSingleKey(publicKey))
    };
  }
}

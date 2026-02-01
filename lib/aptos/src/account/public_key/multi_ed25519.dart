import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/constant/constants.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/keys/ed25519.dart';
import 'package:on_chain/serialization/bcs/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosMultiEd25519AccountPublicKey extends AptosAccountPublicKey {
  /// List of public keys
  final List<AptosED25519PublicKey> publicKeys;

  /// Minimum number of signatures required
  final int threshold;
  AptosMultiEd25519AccountPublicKey._(
      {required List<AptosED25519PublicKey> publicKeys, required int threshold})
      : publicKeys = publicKeys.immutable,
        threshold = threshold.asU8,
        super(scheme: AptosSigningScheme.multiEd25519);
  factory AptosMultiEd25519AccountPublicKey(
      {required List<AptosED25519PublicKey> publicKeys,
      required int threshold}) {
    final keys = publicKeys.toSet();
    if (keys.length != publicKeys.length) {
      throw DartAptosPluginException("Duplicate public key detected.");
    }
    if (publicKeys.length < AptosAccountConst.multiEd25519MinKeys ||
        publicKeys.length > AptosAccountConst.multiEd25519MaxKeys) {
      throw DartAptosPluginException(
          "The number of public keys provided is invalid. It must be between ${AptosAccountConst.multiEd25519MinKeys} and ${AptosAccountConst.multiEd25519MaxKeys}.");
    }
    if (threshold < AptosAccountConst.multiEd25519MinThreshold ||
        threshold > publicKeys.length) {
      throw DartAptosPluginException(
          "Invalid threshold. The threshold must be between ${AptosAccountConst.multiEd25519MinThreshold} and the number of provided public keys (${publicKeys.length}).");
    }
    return AptosMultiEd25519AccountPublicKey._(
        publicKeys: publicKeys, threshold: threshold);
  }

  factory AptosMultiEd25519AccountPublicKey.fromBytes(List<int> bytes) {
    if ((bytes.length - 1) % Ed25519KeysConst.pubKeyByteLen != 0) {
      throw DartAptosPluginException(
          "Invalid MultiEd25519Account bytes length.",
          details: {"length": bytes.length});
    }
    final pubkeysLength = (bytes.length - 1) ~/ Ed25519KeysConst.pubKeyByteLen;
    return AptosMultiEd25519AccountPublicKey(
        publicKeys: List.generate(pubkeysLength, (i) {
          final index = i * Ed25519KeysConst.pubKeyByteLen;
          return AptosED25519PublicKey.fromBytes(
              bytes.sublist(index, index + Ed25519KeysConst.pubKeyByteLen));
        }),
        threshold: bytes.last);
  }

  factory AptosMultiEd25519AccountPublicKey.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosMultiEd25519AccountPublicKey.fromStruct(decode);
  }
  factory AptosMultiEd25519AccountPublicKey.fromStruct(
      Map<String, dynamic> json) {
    return AptosMultiEd25519AccountPublicKey.fromBytes(json.asBytes("bytes"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([LayoutConst.bcsBytes(property: 'bytes')],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  List<int> toBytes() {
    return [
      ...publicKeys.map((e) => e.publicKeyBytes()).expand((e) => e),
      threshold
    ];
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"bytes": toBytes()};
  }

  @override
  AptosAddress toAddress() {
    return AptosAddress(AptosAddrEncoder().encodeMultiEd25519Key(
        publicKeys: publicKeys.map((e) => e.publicKey).toList(),
        threshold: threshold));
  }

  @override
  bool verifySignature(
      {required List<int> message, required List<int> signature}) {
    AptosMultiEd25519Signature anySignature;
    try {
      anySignature = AptosMultiEd25519Signature.deserialize(signature);
    } catch (_) {
      throw DartAptosPluginException(
          "Invalid Aptos MultiED25519 Signature. deserialize signature failed.");
    }
    if (anySignature.signatures.isEmpty) return false;
    final indexes = anySignature.getIndexesBitmap(anySignature.bitmap);
    for (int i = 0; i < indexes.length; i++) {
      final signature = anySignature.signatures[i];
      final pubkeyIndex = indexes[i];
      if (pubkeyIndex >= publicKeys.length) return false;
      final publicKey = publicKeys.elementAt(pubkeyIndex);
      if (!publicKey.verify(message: message, signature: signature.signature)) {
        return false;
      }
    }
    return true;
  }
}

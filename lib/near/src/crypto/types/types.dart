import 'package:blockchain_utils/chain/signer/signer.dart';

import 'package:blockchain_utils/crypto/crypto/keys/keys.dart';
import 'package:blockchain_utils/crypto/quick_crypto.dart';
import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';
import 'package:on_chain/near/src/transaction/src/transaction.dart';

enum NearKeyType {
  ed25519(
    0,
    "ed25519",
    CryptoSignerConst.ed25519SignatureLength,

    Ed25519KeysConst.pubKeyByteLen,
  ),
  secp256k1(
    1,
    "secp256k1",
    CryptoSignerConst.ecdsaSignatureLength +
        CryptoSignerConst.ecdsaRecoveryIdLength,

    EcdsaKeysConst.pubKeyUncompressedByteLen - 1,
  ),
  mldsa65(2, "ml-dsa-65", 3309, 1952);

  final int value;
  final String prefix;
  // final String keyName;
  final int signatureBytesLength;
  final int encodePublicKeyBytesLength;
  const NearKeyType(
    this.value,
    this.prefix,
    this.signatureBytesLength,
    // this.keyName,
    this.encodePublicKeyBytesLength,
  );

  static NearKeyType fromValue(int value) {
    return NearKeyType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.nearPlugin(
                "NearKeyType.fromValue",
                reason: "Invalid NEAR key type value.",
                details: {"value": "$value"},
              ),
    );
  }

  static NearKeyType fromName(String keyName) {
    return NearKeyType.values.firstWhere(
      (e) => e.name == keyName,
      orElse:
          () =>
              throw OnChainErrors.nearPlugin(
                "NearKeyType.fromName",
                reason: "Invalid NEAR key type name.",
                details: {"name": keyName},
              ),
    );
  }

  static NearKeyType fromPrefix(String prefix) {
    prefix = prefix.toLowerCase();
    return NearKeyType.values.firstWhere(
      (e) => e.prefix == prefix,
      orElse:
          () =>
              throw OnChainErrors.nearPlugin(
                "NearKeyType.fromPrefix",
                reason: "Invalid NEAR key type prefix.",
                details: {"prefix": prefix},
              ),
    );
  }

  static NearKeyType? findEncodingAlgorithm(String key) {
    final split = key.split(":");
    if (split.length != 2) return null;
    final type = split[0].toLowerCase();
    if (type == "ml-dsa-65-hash") {
      return NearKeyType.mldsa65;
    }
    return NearKeyType.values.firstWhereNullable((e) => e.prefix == type);
  }
}

sealed class NearSignature with VariantLayoutSerializable {
  final NearKeyType type;
  final List<int> data;
  NearSignature({required this.type, required List<int> data})
    : data = data.asImmutableBytes.exc(
        length: type.signatureBytesLength,
        operation: "Invalid ${type.name} signature bytes length.",
      );

  factory NearSignature.fromKeyType({
    required NearKeyType keyType,
    required List<int> data,
  }) {
    return switch (keyType) {
      NearKeyType.ed25519 => NearSignatureED25519(data),
      NearKeyType.secp256k1 => NearSignatureSECP256K1(data),
      NearKeyType.mldsa65 => NearSignatureMLDSA65(data),
    };
  }
  factory NearSignature.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearSignature.layout(),
    );
    return NearSignature.deserializeJson(decode);
  }
  factory NearSignature.deserializeJson(Map<String, dynamic> json) {
    final decode = VariantLayoutSerializable.toVariantDecodeResult(json);
    final type = NearKeyType.fromName(decode.variantName);
    return switch (type) {
      NearKeyType.ed25519 => NearSignatureED25519.deserializeJson(decode.value),
      NearKeyType.secp256k1 => NearSignatureSECP256K1.deserializeJson(
        decode.value,
      ),
      NearKeyType.mldsa65 => NearSignatureMLDSA65.deserializeJson(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum([
      LazyVariantModel(
        layout: NearSignatureED25519.layout,
        property: NearKeyType.ed25519.name,
        index: NearKeyType.ed25519.value,
      ),
      LazyVariantModel(
        layout: NearSignatureSECP256K1.layout,
        property: NearKeyType.secp256k1.name,
        index: NearKeyType.secp256k1.value,
      ),
      LazyVariantModel(
        layout: NearSignatureMLDSA65.layout,
        property: NearKeyType.mldsa65.name,
        index: NearKeyType.mldsa65.value,
      ),
    ], property: property);
  }

  @override
  String get variantName => type.name;
  @override
  Layout<Map<String, dynamic>> toVariantLayout({String? property}) {
    return layout(property: property);
  }
}

class NearSignatureED25519 extends NearSignature {
  NearSignatureED25519(List<int> data)
    : super(data: data, type: NearKeyType.ed25519);
  factory NearSignatureED25519.deserializeJson(Map<String, dynamic> json) {
    return NearSignatureED25519(json.valueAsBytes("data"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        NearKeyType.ed25519.signatureBytesLength,
        property: "data",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"data": data};
  }
}

class NearSignatureSECP256K1 extends NearSignature {
  NearSignatureSECP256K1(List<int> data)
    : super(data: data, type: NearKeyType.secp256k1);
  factory NearSignatureSECP256K1.deserializeJson(Map<String, dynamic> json) {
    return NearSignatureSECP256K1(json.valueAsBytes("data"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        NearKeyType.secp256k1.signatureBytesLength,
        property: "data",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"data": data};
  }
}

class NearSignatureMLDSA65 extends NearSignature {
  NearSignatureMLDSA65(List<int> data)
    : super(data: data, type: NearKeyType.mldsa65);

  factory NearSignatureMLDSA65.deserializeJson(Map<String, dynamic> json) {
    return NearSignatureMLDSA65(json.valueAsBytes("data"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        NearKeyType.mldsa65.signatureBytesLength,
        property: "data",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"data": data};
  }
}

class NearSignedTransactionWithHash {
  final NearSignedTransaction signedTransaction;
  final List<int> hash;
  NearSignedTransactionWithHash({
    required this.signedTransaction,
    required List<int> hash,
  }) : hash =
           hash
               .exc(
                 length: 32,
                 operation: "NearSignedTransactionWithHash",
                 reason: "Invalid hash bytes length.",
               )
               .asImmutableBytes;
}

class NearSignedDelegateAction {
  final NearSignedDelegate delegate;
  final List<int> hash;
  NearSignedDelegateAction({required this.delegate, required List<int> hash})
    : hash =
          hash
              .exc(
                length: 32,
                operation: "NearSignedDelegateAction",
                reason:
                    "Invalid delegate hash bytes length: expected 32, got ${hash.length}.",
              )
              .asImmutableBytes;
}

class Nep413MessagePayload with LayoutSerializable {
  final String message;
  final String recipient;
  final List<int> nonce;
  final String? callbackUrl;
  Nep413MessagePayload({
    required this.message,
    required this.recipient,
    required List<int> nonce,
    this.callbackUrl,
  }) : nonce = nonce.asImmutableBytes.exc(
         length: 32,
         operation: "MessagePayload",
         reason: "Invalid nonce bytes length.",
       );
  factory Nep413MessagePayload.deserializeJson(Map<String, dynamic> json) {
    return Nep413MessagePayload(
      message: json.valueAsString("message"),
      recipient: json.valueAsString("recipient"),
      nonce: json.valueAsBytes("nonce"),
      callbackUrl: json.valueAs("callbackUrl"),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.string(property: "message"),
      LayoutConst.fixedBlob32(property: "nonce"),
      LayoutConst.string(property: "recipient"),
      LayoutConst.optional(LayoutConst.string(), property: "callbackUrl"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "message": message,
      "nonce": nonce,
      "recipient": recipient,
      "callbackUrl": callbackUrl,
    };
  }

  List<int> encodeSign() {
    final prefixBytes = LayoutConst.u32().serialize(2147484061);
    final messageBytes = toSerializeBytes();
    return QuickCrypto.sha256Hash([...prefixBytes, ...messageBytes]);
  }
}

class Nep413SignedMessage {
  final String accountId;
  final NearPublicKey publicKey;
  final List<int> signature;
  final String? state;
  Nep413SignedMessage({
    required this.accountId,
    required this.publicKey,
    required List<int> signature,
    this.state,
  }) : signature = signature.asImmutableBytes;
}

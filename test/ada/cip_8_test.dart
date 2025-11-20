import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/shelly/base_address.dart';
import 'package:on_chain/ada/src/cip_8/models/models.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:test/test.dart';

void main() {
  group("CIP-8", () {
    _test();
    _testCOSEKey();
    _serialization();
  });
}

void _test() {
  test('COSESign1', () {
    final payload =
        "01871367c94328605ab54631539f118d935e12c7a136d40693546f0917e454ee23d6dc526c1ed6fd12e3a06a3e80ab7aad863331da0135518a";
    final address = ADABaseAddress(
        "addr1qxr3xe7fgv5xqk44gcc488c33kf4uyk85ymdgp5n23hsj9ly2nhz84ku2fkpa4hazt36q637sz4h4tvxxvca5qf42x9qty8td6");
    final builder = COSESign1Builder(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap(
              CborMapValue<CborObject, CborObject>.definite({
                CborIntValue(COSEKeyType.okp.value):
                    CborIntValue(COSEAlgorithmId.eddsa.value),
                CborStringValue("address"): CborBytesValue(address.toBytes()),
              }).encode(),
            ),
            unprotected: COSEHeaderMap()),
        payload: BytesUtils.fromHexString(payload),
        externalAad: []);
    expect(BytesUtils.toHexString(builder.toSignMessageBytes()),
        "846a5369676e6174757265315846a201276761646472657373583901871367c94328605ab54631539f118d935e12c7a136d40693546f0917e454ee23d6dc526c1ed6fd12e3a06a3e80ab7aad863331da0135518a40583901871367c94328605ab54631539f118d935e12c7a136d40693546f0917e454ee23d6dc526c1ed6fd12e3a06a3e80ab7aad863331da0135518a");
    final signature = BytesUtils.fromHexString(
        "55d6d34a4857b29ee2099bb3a3149dcb1340e982ec47a215fd903bacdd3d2b89cfbf3e580a81c3762bcffd321a365da2c97b2a894a4f048e015d6a446f202002");

    final toSign = builder.toSignHex(signature);
    expect(toSign,
        "845846a201276761646472657373583901871367c94328605ab54631539f118d935e12c7a136d40693546f0917e454ee23d6dc526c1ed6fd12e3a06a3e80ab7aad863331da0135518aa166686173686564f4583901871367c94328605ab54631539f118d935e12c7a136d40693546f0917e454ee23d6dc526c1ed6fd12e3a06a3e80ab7aad863331da0135518a584055d6d34a4857b29ee2099bb3a3149dcb1340e982ec47a215fd903bacdd3d2b89cfbf3e580a81c3762bcffd321a365da2c97b2a894a4f048e015d6a446f202002");
  });
}

void _testCOSEKey() {
  test('COSEKey', () {
    final coseKey = COSEKey.deserialize(CborObject.fromCborHex(
            "a401010327200621582090a4c17d82481934974c394bcf65bbee9f1379803c11b2c2c600006c365d54a6")
        .as());
    final publicKey = BytesUtils.fromHexString(
        "90a4c17d82481934974c394bcf65bbee9f1379803c11b2c2c600006c365d54a6");
    final newKey =
        COSEKey.fromEd25519Keypair(publicKey: publicKey, forVerifying: false);
    expect(newKey.serializeHex(),
        "a401010327200621582090a4c17d82481934974c394bcf65bbee9f1379803c11b2c2c600006c365d54a6");
    expect(newKey.serializeHex(), coseKey.serializeHex());
  });
}

// COSEHeaders _buildHeader(
//     {String algorithmId = "alg", String contentType = "type"}) {
//   final header = COSEHeaderMap(
//       algorithmId: COSELabelString(algorithmId),
//       contentType: COSELabelString(contentType),
//       otherHeaders: {COSELabelString("hashed"): CborBoleanValue(false)});
//   return COSEHeaders(protected: COSEProtectedHeaderMap(), unprotected: header);
// }

COSEHeaders _buildHeaderLargeHeader(
    {String algorithmId = "alg", String contentType = "type"}) {
  final header = COSEHeaderMap(
      algorithmId: COSELabelString(algorithmId),
      contentType: COSELabelString(contentType),
      criticality: COSELabels(labels: [
        COSELabelString("one"),
        COSELabelInt.fromInt(1),
      ]),
      initVector: List<int>.filled(12, 3),
      keyId: List<int>.filled(12, 3),
      partialInitVector: List<int>.filled(12, 3),
      otherHeaders: {
        COSELabelString("hashed"): CborBoleanValue(false),
        COSELabelString("one"): CborStringValue("one"),
        COSELabelString("two"): CborIntValue(2),
        COSELabelString("three"):
            CborTagValue(CborListValue.definite([CborIntValue(1)]), [97]),
      });
  return COSEHeaders(protected: COSEProtectedHeaderMap(), unprotected: header);
}

COSESignature _buildSignature(
    {List<int>? signature,
    String algorithmId = "alg",
    String contentType = "type"}) {
  final sig = COSESignature(
      headers: _buildHeaderLargeHeader(
          algorithmId: algorithmId, contentType: contentType),
      signatures: signature ?? List<int>.filled(32, 0));
  final decode = COSESignature.deserialize(
      CborObject.fromCbor(sig.toCbor().encode()).as<CborIterableObject>());
  expect(decode.headers.unprotected.contentType, COSELabelString(contentType));
  expect(decode.headers.unprotected.algorithmId, COSELabelString(algorithmId));
  expect(decode.headers.unprotected.otherHeaders?.length, 4);
  expect(decode.signature, signature ?? List<int>.filled(32, 0));
  return decode;
}

void _serialization() {
  test('COSESignature', () {
    final sig = _buildSignature();
    final decode = COSESignature.deserialize(
        CborObject.fromCbor(sig.toCbor().encode()).as<CborIterableObject>());
    expect(decode.headers.unprotected.contentType, COSELabelString("type"));
    expect(decode.headers.unprotected.algorithmId, COSELabelString("alg"));
    expect(decode.headers.unprotected.otherHeaders?.length, 4);
    expect(decode.signature, List<int>.filled(32, 0));
    expect(decode.toCbor().toCborHex(), sig.toCbor().toCborHex());
    final json = COSESignature.fromJson(decode.toJson());
    expect(decode.serializeHex(), json.serializeHex());
  });
  test('COSECounterSignature', () {
    // final sig = _buildSignature();
    final sig = COSECounterSignature(signatures: [_buildSignature()]);
    final decode = COSECounterSignature.deserialize(
        CborObject.fromCbor(sig.toCbor().encode()).as<CborIterableObject>());
    expect(decode.signatures.length, 1);
    expect(decode.signatures[0].headers.unprotected.contentType,
        COSELabelString("type"));
    expect(decode.signatures[0].headers.unprotected.algorithmId,
        COSELabelString("alg"));
    expect(decode.signatures[0].headers.unprotected.otherHeaders?.length, 4);
    expect(decode.signatures[0].signature, List<int>.filled(32, 0));
    expect(decode.toCbor().toCborHex(), sig.toCbor().toCborHex());
    final json = COSECounterSignature.fromJson(decode.toJson());
    expect(decode.serializeHex(), json.serializeHex());
  });
  test('COSECounterSignature 2', () {
    final sig = COSECounterSignature(signatures: [
      _buildSignature(),
      _buildSignature(algorithmId: "alg2", signature: List<int>.filled(32, 2))
    ]);
    final decode = COSECounterSignature.deserialize(
        CborObject.fromCbor(sig.toCbor().encode()).as<CborIterableObject>());
    expect(decode.signatures.length, 2);
    expect(decode.signatures[0].headers.unprotected.contentType,
        COSELabelString("type"));
    expect(decode.signatures[1].headers.unprotected.algorithmId,
        COSELabelString("alg2"));
    expect(decode.signatures[0].headers.unprotected.otherHeaders?.length, 4);
    expect(decode.signatures[1].signature, List<int>.filled(32, 2));
    expect(decode.toCbor().toCborHex(), sig.toCbor().toCborHex());
    final json = COSECounterSignature.fromJson(decode.toJson());
    expect(decode.serializeHex(), json.serializeHex());
  });

  test('COSESign1 2', () {
    final sig = COSESign1(
      headers: _buildHeaderLargeHeader(),
      signature: List<int>.filled(32, 2),
      payload: List<int>.filled(32, 2),
    );
    final decode = COSESign1.deserialize(
        CborObject.fromCbor(sig.toCbor().encode()).as<CborIterableObject>());
    expect(decode.headers.unprotected.algorithmId, COSELabelString("alg"));
    expect(decode.serializeHex(), sig.serializeHex());
    final decodeView =
        COSESignedMessage.fromUserFacingEncoding(decode.toUserFacingEncoding());

    expect(decodeView, isA<COSESign1>());
    expect((decodeView as COSESign1).headers.unprotected.algorithmId,
        COSELabelString("alg"));
    expect(decodeView.serializeHex(), sig.serializeHex());
    final json = COSESignedMessage.fromJson(decodeView.toJson());
    expect(decodeView.serializeHex(), json.serializeHex());
  });
}

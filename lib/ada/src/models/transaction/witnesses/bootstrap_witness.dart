import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

import 'witness.dart';

/// Represents a bootstrap (Byron) witness.
class BootstrapWitness
    with ADASerialization
    implements ADABaseTransactionWitness {
  final Vkey vkey;
  final Ed25519Signature signature;
  final List<int> chainCode;
  final List<int> attributes;

  /// Constructor for creating a BootstrapWitness.
  BootstrapWitness({
    required this.vkey,
    required this.signature,
    required List<int> chainCode,
    required List<int> attributes,
  })  : chainCode = BytesUtils.toBytes(chainCode, unmodifiable: true),
        attributes = BytesUtils.toBytes(attributes, unmodifiable: true);
  factory BootstrapWitness.deserialize(CborListValue cbor) {
    return BootstrapWitness(
        vkey: Vkey.deserialize(cbor.getIndex(0)),
        signature: Ed25519Signature.deserialize(cbor.getIndex(1)),
        chainCode: cbor.getIndex(2),
        attributes: cbor.getIndex(3));
  }
  factory BootstrapWitness.fromJson(Map<String, dynamic> json) {
    return BootstrapWitness(
        vkey: Vkey.fromHex(json["vkey"]),
        signature: Ed25519Signature.fromHex(json["signature"]),
        chainCode: BytesUtils.fromHexString(json["chain_code"]),
        attributes: BytesUtils.fromHexString(json["attributes"]));
  }

  BootstrapWitness copyWith({
    Vkey? vkey,
    Ed25519Signature? signature,
    List<int>? chainCode,
    List<int>? attributes,
  }) {
    return BootstrapWitness(
      vkey: vkey ?? this.vkey,
      signature: signature ?? this.signature,
      chainCode: chainCode ?? this.chainCode,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      vkey.toCbor(),
      signature.toCbor(),
      CborBytesValue(chainCode),
      CborBytesValue(attributes)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "vkey": vkey.toJson(),
      "signature": signature.toJson(),
      "chain_code": BytesUtils.toHexString(chainCode),
      "attributes": BytesUtils.toHexString(attributes)
    };
  }

  @override
  bool get isByron => true;
}

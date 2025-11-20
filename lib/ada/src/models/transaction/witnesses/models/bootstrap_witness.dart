import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

import 'witness.dart';

/// Represents a bootstrap (Byron) witness.
class BootstrapWitness
    with InternalCborSerialization
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
  })  : chainCode = chainCode.asImmutableBytes,
        attributes = attributes.asImmutableBytes;
  factory BootstrapWitness.deserialize(CborListValue cbor) {
    return BootstrapWitness(
        vkey: Vkey.deserialize(cbor.elementAt<CborBytesValue>(0)),
        signature:
            Ed25519Signature.deserialize(cbor.elementAt<CborBytesValue>(1)),
        chainCode: cbor.elementAtBytes(2),
        attributes: cbor.elementAtBytes(3));
  }
  factory BootstrapWitness.fromJson(Map<String, dynamic> json) {
    return BootstrapWitness(
        vkey: Vkey.fromHex(json['vkey']),
        signature: Ed25519Signature.fromHex(json['signature']),
        chainCode: BytesUtils.fromHexString(json['chain_code']),
        attributes: BytesUtils.fromHexString(json['attributes']));
  }

  BootstrapWitness copyWith(
      {Vkey? vkey,
      Ed25519Signature? signature,
      List<int>? chainCode,
      List<int>? attributes}) {
    return BootstrapWitness(
      vkey: vkey ?? this.vkey,
      signature: signature ?? this.signature,
      chainCode: chainCode ?? this.chainCode,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      vkey.toCbor(),
      signature.toCbor(),
      CborBytesValue(chainCode),
      CborBytesValue(attributes)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'vkey': vkey.toJson(),
      'signature': signature.toJson(),
      'chain_code': BytesUtils.toHexString(chainCode),
      'attributes': BytesUtils.toHexString(attributes)
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! BootstrapWitness) return false;
    return vkey == other.vkey &&
        signature == other.signature &&
        BytesUtils.bytesEqual(chainCode, other.chainCode) &&
        BytesUtils.bytesEqual(attributes, other.attributes);
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode(
      [vkey, signature, chainCode, attributes]);

  @override
  bool get isByron => true;
}

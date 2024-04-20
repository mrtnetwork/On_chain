import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

import 'witness.dart';

/// Represents a witness for a Vkey along with its corresponding Ed25519 signature.
class Vkeywitness with ADASerialization implements ADABaseTransactionWitness {
  final Vkey vKey;
  final Ed25519Signature signature;

  /// Constructs a Vkeywitness with the provided Vkey and signature.
  const Vkeywitness({required this.vKey, required this.signature});

  /// Deserialize a Vkeywitness from a CBOR list value.
  factory Vkeywitness.deserialize(CborListValue cbor) {
    return Vkeywitness(
      vKey: Vkey.deserialize(cbor.getIndex(0)),
      signature: Ed25519Signature.deserialize(cbor.getIndex(1)),
    );
  }
  factory Vkeywitness.fromJson(Map<String, dynamic> json) {
    return Vkeywitness(
        vKey: Vkey.fromHex(json["vkey"]),
        signature: Ed25519Signature.fromHex(json["signature"]));
  }

  Vkeywitness copyWith({
    Vkey? vKey,
    Ed25519Signature? signature,
  }) {
    return Vkeywitness(
      vKey: vKey ?? this.vKey,
      signature: signature ?? this.signature,
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([vKey.toCbor(), signature.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"vkey": vKey.toJson(), "signature": signature.toJson()};
  }

  @override
  bool get isByron => false;
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script_type.dart';
import 'package:on_chain/ada/src/models/native_script/utils/native_script_utils.dart';

/// Represents a native script that verifies against a public key.
class NativeScriptScriptPubkey extends NativeScript {
  /// The address key hash.
  final Ed25519KeyHash addressKeyHash;

  /// Constructs a [NativeScriptScriptPubkey].
  const NativeScriptScriptPubkey(this.addressKeyHash);

  /// Constructs a [NativeScriptScriptPubkey] from a public key.
  factory NativeScriptScriptPubkey.fromPubKey(List<int> pubkeyBytes) {
    return NativeScriptScriptPubkey(Ed25519KeyHash.fromPubkey(pubkeyBytes));
  }

  /// Deserializes a [NativeScriptScriptPubkey] from CBOR.
  factory NativeScriptScriptPubkey.deserialize(CborListValue cbor) {
    NativeScriptUtils.validateCborTypeObject(
        cbor.getIndex(0), NativeScriptType.scriptPubkey);
    return NativeScriptScriptPubkey(
      Ed25519KeyHash.deserialize(cbor.getIndex<CborBytesValue>(1)),
    );
  }
  NativeScriptScriptPubkey copyWith({Ed25519KeyHash? addressKeyHash}) {
    return NativeScriptScriptPubkey(addressKeyHash ?? this.addressKeyHash);
  }

  factory NativeScriptScriptPubkey.fromJson(Map<String, dynamic> json) {
    return NativeScriptScriptPubkey(Ed25519KeyHash.fromHex(
        json['address_key_hash'] ?? json['script_pubkey']['address_key_hash']));
  }
  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      addressKeyHash.toCbor(),
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptPubkey;

  @override
  Map<String, dynamic> toJson() {
    return {
      'script_pubkey': {'address_key_hash': addressKeyHash.toJson()}
    };
  }
}

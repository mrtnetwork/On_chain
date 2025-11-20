import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script_type.dart';
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
        cbor.elementAt<CborObject>(0), NativeScriptType.scriptPubkey);
    return NativeScriptScriptPubkey(
      Ed25519KeyHash.deserialize(cbor.elementAt<CborBytesValue>(1)),
    );
  }
  NativeScriptScriptPubkey copyWith({Ed25519KeyHash? addressKeyHash}) {
    return NativeScriptScriptPubkey(addressKeyHash ?? this.addressKeyHash);
  }

  factory NativeScriptScriptPubkey.fromJson(Map<String, dynamic> json) {
    final correctJson = json[NativeScriptType.scriptPubkey.name] ?? json;
    return NativeScriptScriptPubkey(
        Ed25519KeyHash.fromHex(correctJson['addr_keyhash']));
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      addressKeyHash.toCbor(),
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptPubkey;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'addr_keyhash': addressKeyHash.toJson()}
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! NativeScriptScriptPubkey) return false;
    return other.addressKeyHash == addressKeyHash;
  }

  @override
  int get hashCode =>
      HashCodeGenerator.generateHashCode([addressKeyHash, type]);
}

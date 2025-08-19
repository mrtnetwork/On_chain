import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script_type.dart';

import 'script_all.dart';
import 'script_any.dart';
import 'script_n_of_k.dart';
import 'script_pub_key.dart';
import 'time_lock_start.dart';
import 'timelock_expiry.dart';

/// Represents a native script.
abstract class NativeScript with ADASerialization {
  /// Constructs a [NativeScript].
  const NativeScript();

  /// The type of the native script.
  abstract final NativeScriptType type;

  /// Deserializes a [NativeScript] from CBOR.
  factory NativeScript.deserialize(CborListValue cbor) {
    final type = NativeScriptType.deserialize(cbor.elementAt<CborIntValue>(0));
    switch (type) {
      case NativeScriptType.scriptAll:
        return NativeScriptScriptAll.deserialize(cbor);
      case NativeScriptType.scriptAny:
        return NativeScriptScriptAny.deserialize(cbor);
      case NativeScriptType.scriptNOfK:
        return NativeScriptScriptNOfK.deserialize(cbor);
      case NativeScriptType.scriptPubkey:
        return NativeScriptScriptPubkey.deserialize(cbor);
      case NativeScriptType.timelockStart:
        return NativeScriptTimelockStart.deserialize(cbor);
      default:
        return NativeScriptTimelockExpiry.deserialize(cbor);
    }
  }

  factory NativeScript.fromJson(Map<String, dynamic> json) {
    final NativeScriptType type;
    try {
      type = NativeScriptType.fromName(json.keys.first);
    } on StateError {
      throw ADAPluginException('Invalid NativeScript json.',
          details: {'json': json});
    }
    switch (type) {
      case NativeScriptType.scriptAll:
        return NativeScriptScriptAll.fromJson(json);
      case NativeScriptType.scriptAny:
        return NativeScriptScriptAny.fromJson(json);
      case NativeScriptType.scriptNOfK:
        return NativeScriptScriptNOfK.fromJson(json);
      case NativeScriptType.scriptPubkey:
        return NativeScriptScriptPubkey.fromJson(json);
      case NativeScriptType.timelockStart:
        return NativeScriptTimelockStart.fromJson(json);
      default:
        return NativeScriptTimelockExpiry.fromJson(json);
    }
  }

  /// Generates the hash of the native script.
  ScriptHash toHash() {
    return ScriptHash(QuickCrypto.blake2b224Hash([0, ...serialize()]));
  }

  @override
  Map<String, dynamic> toJson();
}

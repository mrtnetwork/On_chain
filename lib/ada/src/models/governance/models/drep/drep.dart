import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

import 'drep_type.dart';

abstract class DRep with InternalCborSerialization {
  final DRepType type;
  const DRep({required this.type});

  factory DRep.fromJson(Map<String, dynamic> json) {
    final type = DRepType.fromJson(json);
    return switch (type) {
      DRepType.drepKeyHash => DRepKeyHash.fromJson(json),
      DRepType.drepScriptHash => DRepScriptHash.fromJson(json),
      DRepType.alwaysAbstain => AlwaysAbstain.fromJson(json),
      DRepType.alwaysNoConfidence => AlwaysNoConfidence.fromJson(json),
      _ => throw UnimplementedError("Invalid drep type.")
    };
  }
  factory DRep.deserialize(CborListValue cbor) {
    final type = DRepType.deserialize(cbor.elementAt<CborIntValue>(0));
    return switch (type) {
      DRepType.drepKeyHash => DRepKeyHash.deserialize(cbor),
      DRepType.drepScriptHash => DRepScriptHash.deserialize(cbor),
      DRepType.alwaysAbstain => AlwaysAbstain.deserialize(cbor),
      DRepType.alwaysNoConfidence => AlwaysNoConfidence.deserialize(cbor),
      _ => throw UnimplementedError("Invalid drep type.")
    };
  }
}

class DRepKeyHash extends DRep {
  final Ed25519KeyHash key;
  const DRepKeyHash(this.key) : super(type: DRepType.drepKeyHash);
  factory DRepKeyHash.deserialize(CborListValue cbor) {
    DRepType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: DRepType.drepKeyHash);
    return DRepKeyHash(
        Ed25519KeyHash.deserialize(cbor.elementAt<CborBytesValue>(1)));
  }
  factory DRepKeyHash.fromJson(Map<String, dynamic> json) {
    DRepType.fromJson(json, validate: DRepType.drepKeyHash);
    return DRepKeyHash(Ed25519KeyHash.fromHex(json["key_hash"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), key.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"key_hash": key.toHex()};
  }
}

class DRepScriptHash extends DRep {
  final ScriptHash scriptHash;
  const DRepScriptHash(this.scriptHash) : super(type: DRepType.drepScriptHash);
  factory DRepScriptHash.deserialize(CborListValue cbor) {
    DRepType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: DRepType.drepScriptHash);
    return DRepScriptHash(
        ScriptHash.deserialize(cbor.elementAt<CborBytesValue>(1)));
  }
  factory DRepScriptHash.fromJson(Map<String, dynamic> json) {
    DRepType.fromJson(json, validate: DRepType.drepScriptHash);
    return DRepScriptHash(ScriptHash.fromHex(json["script_hash"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), scriptHash.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"script_hash": scriptHash.toHex()};
  }
}

class AlwaysAbstain extends DRep {
  const AlwaysAbstain() : super(type: DRepType.alwaysAbstain);
  factory AlwaysAbstain.deserialize(CborListValue cbor) {
    DRepType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: DRepType.alwaysAbstain);
    return AlwaysAbstain();
  }
  factory AlwaysAbstain.fromJson(Map<String, dynamic> json) {
    DRepType.fromJson(json, validate: DRepType.alwaysAbstain);
    return AlwaysAbstain();
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"always_abstain": {}};
  }
}

class AlwaysNoConfidence extends DRep {
  const AlwaysNoConfidence() : super(type: DRepType.alwaysNoConfidence);
  factory AlwaysNoConfidence.deserialize(CborListValue cbor) {
    DRepType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: DRepType.alwaysNoConfidence);
    return AlwaysNoConfidence();
  }
  factory AlwaysNoConfidence.fromJson(Map<String, dynamic> json) {
    DRepType.fromJson(json, validate: DRepType.alwaysNoConfidence);
    return AlwaysNoConfidence();
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"always_no_confidence": {}};
  }
}

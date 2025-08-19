import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/credential/models/key.dart';
import 'package:on_chain/ada/src/models/credential/models/script.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/governance/models/voter_type.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

abstract class Voter with ADASerialization {
  final VoterType type;
  const Voter({required this.type});

  factory Voter.fromJson(Map<String, dynamic> json) {
    final type = VoterType.fromName(json.keys.firstOrNull);
    return switch (type) {
      VoterType.constitutionalCommitteeHotKeyHash =>
        VoterConstitutionalCommitteeHotKeyHash.fromJson(json),
      VoterType.constitutionalCommitteeHotScriptHash =>
        VoterConstitutionalCommitteeHotScriptHash.fromJson(json),
      VoterType.drepKeyHash => VoterDRepKeyHash.fromJson(json),
      VoterType.drepScriptHash => VoterDRepScriptHash.fromJson(json),
      VoterType.stakingPoolKeyHash => VoterStakingPoolKeyHash.fromJson(json),
      _ => throw UnimplementedError("Invalid voter type.")
    };
  }
  factory Voter.deserialize(CborListValue cbor) {
    final type = VoterType.deserialize(cbor.elementAt<CborIntValue>(0).value);
    return switch (type) {
      VoterType.constitutionalCommitteeHotKeyHash =>
        VoterConstitutionalCommitteeHotKeyHash.deserialize(cbor),
      VoterType.constitutionalCommitteeHotScriptHash =>
        VoterConstitutionalCommitteeHotScriptHash.deserialize(cbor),
      VoterType.drepKeyHash => VoterDRepKeyHash.deserialize(cbor),
      VoterType.drepScriptHash => VoterDRepScriptHash.deserialize(cbor),
      VoterType.stakingPoolKeyHash => VoterStakingPoolKeyHash.deserialize(cbor),
      _ => throw UnimplementedError("Invalid voter type.")
    };
  }

  Credential get signersCredential;
}

class VoterConstitutionalCommitteeHotKeyHash extends Voter {
  final CredentialKey key;
  const VoterConstitutionalCommitteeHotKeyHash(this.key)
      : super(type: VoterType.constitutionalCommitteeHotKeyHash);
  factory VoterConstitutionalCommitteeHotKeyHash.deserialize(
      CborListValue cbor) {
    VoterType.deserialize(cbor.elementAt<CborIntValue>(0).value,
        validate: VoterType.constitutionalCommitteeHotKeyHash);
    return VoterConstitutionalCommitteeHotKeyHash(
        CredentialKey(cbor.elementAt<CborBytesValue>(1).value));
  }
  factory VoterConstitutionalCommitteeHotKeyHash.fromJson(
      Map<String, dynamic> json) {
    VoterType.fromJson(json.keys.firstOrNull,
        validate: VoterType.constitutionalCommitteeHotKeyHash);
    return VoterConstitutionalCommitteeHotKeyHash(CredentialKey(
        BytesUtils.fromHexString(
            json["constitutional_committee_hot_key_hash"])));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), CborBytesValue(key.data)]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: BytesUtils.toHexString(key.data)};
  }

  @override
  Credential get signersCredential => key;
}

class VoterConstitutionalCommitteeHotScriptHash extends Voter {
  final CredentialScript script;
  const VoterConstitutionalCommitteeHotScriptHash(this.script)
      : super(type: VoterType.constitutionalCommitteeHotScriptHash);
  factory VoterConstitutionalCommitteeHotScriptHash.deserialize(
      CborListValue cbor) {
    VoterType.deserialize(cbor.elementAt<CborIntValue>(0).value,
        validate: VoterType.constitutionalCommitteeHotScriptHash);
    return VoterConstitutionalCommitteeHotScriptHash(
        CredentialScript(cbor.elementAt<CborBytesValue>(1).value));
  }
  factory VoterConstitutionalCommitteeHotScriptHash.fromJson(
      Map<String, dynamic> json) {
    VoterType.fromJson(json.keys.firstOrNull,
        validate: VoterType.constitutionalCommitteeHotScriptHash);
    return VoterConstitutionalCommitteeHotScriptHash(CredentialScript(
        BytesUtils.fromHexString(
            json["constitutional_committee_hot_script_hash"])));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), CborBytesValue(script.data)]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: BytesUtils.toHexString(script.data)};
  }

  @override
  Credential get signersCredential => script;
}

class VoterDRepKeyHash extends Voter {
  final CredentialKey key;

  const VoterDRepKeyHash(this.key) : super(type: VoterType.drepKeyHash);
  factory VoterDRepKeyHash.deserialize(CborListValue cbor) {
    VoterType.deserialize(cbor.elementAt<CborIntValue>(0).value,
        validate: VoterType.drepKeyHash);
    return VoterDRepKeyHash(
        CredentialKey(cbor.elementAt<CborBytesValue>(1).value));
  }
  factory VoterDRepKeyHash.fromJson(Map<String, dynamic> json) {
    VoterType.fromJson(json.keys.firstOrNull, validate: VoterType.drepKeyHash);
    return VoterDRepKeyHash(
        CredentialKey(BytesUtils.fromHexString(json["drep_key_hash"])));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), CborBytesValue(key.data)]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: BytesUtils.toHexString(key.data)};
  }

  @override
  Credential get signersCredential => key;
}

class VoterDRepScriptHash extends Voter {
  final CredentialScript script;

  const VoterDRepScriptHash(this.script)
      : super(type: VoterType.drepScriptHash);
  factory VoterDRepScriptHash.deserialize(CborListValue cbor) {
    VoterType.deserialize(cbor.elementAt<CborIntValue>(0).value,
        validate: VoterType.drepScriptHash);
    return VoterDRepScriptHash(
        CredentialScript(cbor.elementAt<CborBytesValue>(1).value));
  }
  factory VoterDRepScriptHash.fromJson(Map<String, dynamic> json) {
    VoterType.fromJson(json.keys.firstOrNull,
        validate: VoterType.drepScriptHash);
    return VoterDRepScriptHash(
        CredentialScript(BytesUtils.fromHexString(json["drep_script_hash"])));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), CborBytesValue(script.data)]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: BytesUtils.toHexString(script.data)};
  }

  @override
  Credential get signersCredential => script;
}

class VoterStakingPoolKeyHash extends Voter {
  final Ed25519KeyHash key;

  const VoterStakingPoolKeyHash(this.key)
      : super(type: VoterType.stakingPoolKeyHash);
  factory VoterStakingPoolKeyHash.deserialize(CborListValue cbor) {
    VoterType.deserialize(cbor.elementAt<CborIntValue>(0).value,
        validate: VoterType.stakingPoolKeyHash);
    return VoterStakingPoolKeyHash(
        Ed25519KeyHash(cbor.elementAt<CborBytesValue>(1).value));
  }
  factory VoterStakingPoolKeyHash.fromJson(Map<String, dynamic> json) {
    VoterType.fromJson(json.keys.firstOrNull,
        validate: VoterType.stakingPoolKeyHash);
    return VoterStakingPoolKeyHash(
        Ed25519KeyHash.fromHex(json["staking_pool_key_hash"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), key.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: key.toHex()};
  }

  @override
  Credential get signersCredential => CredentialKey(key.data);
}

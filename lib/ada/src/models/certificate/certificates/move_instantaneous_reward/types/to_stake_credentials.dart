import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/move_instantaneous_reward/types/mir.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

/// Represents a Move Instance Reward allocated to stake credentials, with serialization support.
class MIRToStakeCredentials extends MIR {
  /// The rewards allocated to stake credentials.
  final Map<Credential, BigInt> rewards;

  /// Constructs a MIRToStakeCredentials object with the specified rewards.
  MIRToStakeCredentials(Map<Credential, BigInt> rewards)
      : rewards = Map<Credential, BigInt>.unmodifiable(rewards);

  /// Deserializes a MIRToStakeCredentials object from its CBOR representation.
  factory MIRToStakeCredentials.deserialize(CborMapValue cbor) {
    final map =
        cbor.valueAsMap<CborListValue, CborNumeric>("MIRToStakeCredentials");
    return MIRToStakeCredentials({
      for (final entry in map.entries)
        Credential.deserialize(entry.key): entry.value.toBigInt()
    });
  }
  factory MIRToStakeCredentials.fromJson(Map<dynamic, dynamic> json) {
    return MIRToStakeCredentials({
      for (final i in json.entries)
        Credential.fromJson(i.key): BigintUtils.parse(i.value)
    });
  }
  MIRToStakeCredentials copyWith({Map<Credential, BigInt>? rewards}) {
    return MIRToStakeCredentials(rewards ?? this.rewards);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.definite({
      for (final entry in rewards.entries)
        entry.key.toCbor(): CborSignedValue.i64(entry.value)
    });
  }

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      for (final entry in rewards.entries)
        entry.key.toJson(): entry.value.toString()
    };
  }
}

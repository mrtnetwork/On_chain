import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/types/move_instantaneous_reward/types/mir.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';

/// Represents a Move Instance Reward allocated to stake credentials, with serialization support.
class MIRToStakeCredentials extends MIR {
  /// The rewards allocated to stake credentials.
  final Map<StakeCred, BigInt> rewards;

  /// Constructs a MIRToStakeCredentials object with the specified rewards.
  MIRToStakeCredentials(Map<StakeCred, BigInt> rewards)
      : rewards = Map<StakeCred, BigInt>.unmodifiable(rewards);

  /// Deserializes a MIRToStakeCredentials object from its CBOR representation.
  factory MIRToStakeCredentials.deserialize(CborMapValue cbor) {
    return MIRToStakeCredentials({
      for (final entry
          in cbor.cast<CborMapValue<CborObject, CborObject>>().value.entries)
        StakeCred.deserialize(entry.key.cast()): entry.value.getInteger()
    });
  }
  factory MIRToStakeCredentials.fromJson(Map<dynamic, dynamic> json) {
    return MIRToStakeCredentials({
      for (final i in json.entries)
        StakeCred.fromJson(i.key): BigintUtils.parse(i.value)
    });
  }
  MIRToStakeCredentials copyWith({Map<StakeCred, BigInt>? rewards}) {
    return MIRToStakeCredentials(rewards ?? this.rewards);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.fixedLength({
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

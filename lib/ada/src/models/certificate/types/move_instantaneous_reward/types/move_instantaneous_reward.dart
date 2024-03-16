import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/types/move_instantaneous_reward/types/mir.dart';
import 'package:on_chain/ada/src/models/certificate/types/move_instantaneous_reward/types/mir_pot.dart';

/// Represents a move instantaneous reward.
class MoveInstantaneousReward with ADASerialization {
  /// The pot associated with the reward.
  final MIRPot pot;

  /// The variant of the reward.
  final MIR variant;

  /// Constructs a MoveInstantaneousReward object with the specified pot and variant.
  const MoveInstantaneousReward({required this.pot, required this.variant});

  /// Deserializes a MoveInstantaneousReward object from its CBOR representation.
  factory MoveInstantaneousReward.deserialize(CborListValue cbor) {
    return MoveInstantaneousReward(
        pot: MIRPot.deserialize(cbor.getIndex(0)),
        variant: MIR.deserialize(cbor.getIndex(1)));
  }

  /// Constructs a MoveInstantaneousReward object from its CBOR byte representation.
  factory MoveInstantaneousReward.fromCborBytes(List<int> cborBytes) {
    return MoveInstantaneousReward.deserialize(
        CborObject.fromCbor(cborBytes).cast());
  }
  MoveInstantaneousReward copyWith({MIRPot? pot, MIR? variant}) {
    return MoveInstantaneousReward(
        pot: pot ?? this.pot, variant: variant ?? this.variant);
  }

  factory MoveInstantaneousReward.fromJson(Map<String, dynamic> json) {
    return MoveInstantaneousReward(
        pot: MIRPot.fromName(json["pot"]),
        variant: MIR.fromJson(json["variant"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      pot.toCbor(),
      variant.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"pot": pot.toJson(), "variant": variant.toJson()};
  }
}

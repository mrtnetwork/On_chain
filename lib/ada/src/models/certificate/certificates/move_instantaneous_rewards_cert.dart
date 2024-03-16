import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/core/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/core/types.dart';
import 'package:on_chain/ada/src/models/certificate/types/move_instantaneous_reward/types/move_instantaneous_reward.dart';

/// Represents a move instantaneous rewards certificate with serialization support.
class MoveInstantaneousRewardsCert extends Certificate {
  /// The move instantaneous reward associated with the certificate.
  final MoveInstantaneousReward moveInstantaneousReward;

  /// Constructs a MoveInstantaneousRewardsCert object with the specified move instantaneous reward.
  const MoveInstantaneousRewardsCert(this.moveInstantaneousReward);

  /// Deserializes a MoveInstantaneousRewardsCert object from its CBOR representation.
  factory MoveInstantaneousRewardsCert.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.getIndex(0),
        validate: CertificateType.moveInstantaneousRewardsCert);
    return MoveInstantaneousRewardsCert(
        MoveInstantaneousReward.deserialize(cbor.getIndex(1)));
  }
  factory MoveInstantaneousRewardsCert.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json["move_instantaneous_rewards_cert"] ?? json;
    return MoveInstantaneousRewardsCert(MoveInstantaneousReward.fromJson(
        correctJson["move_instantaneous_reward"]));
  }

  MoveInstantaneousRewardsCert copyWith(
      {MoveInstantaneousReward? moveInstantaneousReward}) {
    return MoveInstantaneousRewardsCert(
        moveInstantaneousReward ?? this.moveInstantaneousReward);
  }

  @override
  CertificateType get type => CertificateType.moveInstantaneousRewardsCert;

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength(
        [type.toCbor(), moveInstantaneousReward.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "move_instantaneous_rewards_cert": {
        "move_instantaneous_reward": moveInstantaneousReward.toJson()
      }
    };
  }
}

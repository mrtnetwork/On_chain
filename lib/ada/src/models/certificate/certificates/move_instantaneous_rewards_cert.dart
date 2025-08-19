import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/move_instantaneous_reward/types/move_instantaneous_reward.dart';

/// Represents a move instantaneous rewards certificate with serialization support.
class MoveInstantaneousRewardsCert extends Certificate {
  /// The move instantaneous reward associated with the certificate.
  final MoveInstantaneousReward moveInstantaneousReward;

  /// Constructs a MoveInstantaneousRewardsCert object with the specified move instantaneous reward.
  const MoveInstantaneousRewardsCert(this.moveInstantaneousReward);

  /// Deserializes a MoveInstantaneousRewardsCert object from its CBOR representation.
  factory MoveInstantaneousRewardsCert.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.moveInstantaneousRewardsCert);
    return MoveInstantaneousRewardsCert(
        MoveInstantaneousReward.deserialize(cbor.elementAt<CborListValue>(1)));
  }
  factory MoveInstantaneousRewardsCert.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.moveInstantaneousRewardsCert.name] ?? json;
    return MoveInstantaneousRewardsCert(MoveInstantaneousReward.fromJson(
        correctJson['move_instantaneous_reward']));
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
    return CborListValue.definite(
        [type.toCbor(), moveInstantaneousReward.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'move_instantaneous_reward': moveInstantaneousReward.toJson()}
    };
  }

  @override
  List<Credential> get signersCredential => [];
}

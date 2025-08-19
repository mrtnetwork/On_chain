import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/move_instantaneous_reward/types/to_other_pot.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/move_instantaneous_reward/types/to_stake_credentials.dart';

/// Abstract class representing a Move Instance Reward with serialization support.
abstract class MIR with ADASerialization {
  const MIR();

  /// Deserializes a MIR object from its CBOR representation.
  factory MIR.deserialize(CborObject cbor) {
    if (cbor.hasType<CborMapValue>()) {
      return MIRToStakeCredentials.deserialize(
          cbor.as("MIRToStakeCredentials"));
    }
    return ToOtherPot.deserialize(cbor.as("ToOtherPot"));
  }

  /// Constructs a MIR object from its CBOR byte representation.
  factory MIR.fromCborBytes(List<int> cborBytes) {
    return MIR.deserialize(CborObject.fromCbor(cborBytes));
  }
  factory MIR.fromJson(dynamic json) {
    if (json is! Map && json is! String) {
      throw ADAPluginException('Invalid MIR json. value must be string or map',
          details: {'json': json});
    }
    if (json is String) {
      return ToOtherPot(BigintUtils.parse(json));
    }
    return MIRToStakeCredentials.fromJson(json);
  }
}

import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/protocol/models/protocol_param_update.dart';

class ProposedProtocolParameterUpdates with InternalCborSerialization {
  final Map<GenesisHash, ProtocolParamUpdate> parameters;

  ProposedProtocolParameterUpdates(
      Map<GenesisHash, ProtocolParamUpdate> parameters)
      : parameters =
            Map<GenesisHash, ProtocolParamUpdate>.unmodifiable(parameters);
  factory ProposedProtocolParameterUpdates.deserialize(CborMapValue cbor) {
    return ProposedProtocolParameterUpdates({
      for (final i in cbor.valueAsMap<CborObject, CborObject>().entries)
        GenesisHash.deserialize(i.key.as<CborBytesValue>("GenesisHash")):
            ProtocolParamUpdate.deserialize(
                i.value.asMap("ProtocolParamUpdate"))
    });
  }
  factory ProposedProtocolParameterUpdates.fromJson(Map<String, dynamic> json) {
    return ProposedProtocolParameterUpdates({
      for (final i in (json["parameters"] as Map).entries)
        GenesisHash.fromHex(i.key): ProtocolParamUpdate.fromJson(i.value)
    });
  }
  ProposedProtocolParameterUpdates copyWith(
      {Map<GenesisHash, ProtocolParamUpdate>? parameters}) {
    return ProposedProtocolParameterUpdates(parameters ?? this.parameters);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.definite(
        {for (final i in parameters.entries) i.key.toCbor(): i.value.toCbor()});
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "parameters": {
        for (final i in parameters.entries) i.key.toJson(): i.value.toJson()
      }
    };
  }
}

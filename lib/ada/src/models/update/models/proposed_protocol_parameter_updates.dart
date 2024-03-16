import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/update/models/protocol_param_update.dart';

class ProposedProtocolParameterUpdates with ADASerialization {
  final Map<GenesisHash, ProtocolParamUpdate> parameters;

  ProposedProtocolParameterUpdates(
      Map<GenesisHash, ProtocolParamUpdate> parameters)
      : parameters =
            Map<GenesisHash, ProtocolParamUpdate>.unmodifiable(parameters);
  factory ProposedProtocolParameterUpdates.deserialize(CborMapValue cbor) {
    return ProposedProtocolParameterUpdates({
      for (final i
          in cbor.cast<CborMapValue<CborObject, CborObject>>().value.entries)
        GenesisHash.deserialize(i.key.cast()):
            ProtocolParamUpdate.deserialize(i.value.cast())
    });
  }
  factory ProposedProtocolParameterUpdates.fromJson(Map<String, dynamic> json) {
    return ProposedProtocolParameterUpdates({
      for (final i in json.entries)
        GenesisHash.fromHex(i.key): ProtocolParamUpdate.fromJson(i.value)
    });
  }
  ProposedProtocolParameterUpdates copyWith(
      {Map<GenesisHash, ProtocolParamUpdate>? parameters}) {
    return ProposedProtocolParameterUpdates(parameters ?? this.parameters);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.fixedLength(
        {for (final i in parameters.entries) i.key.toCbor(): i.value.toCbor()});
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      for (final i in parameters.entries) i.key.toJson(): i.value.toJson()
    };
  }
}

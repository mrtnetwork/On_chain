import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/protocol/models/proposed_protocol_parameter_updates.dart';

class Update with ADASerialization {
  final ProposedProtocolParameterUpdates proposedProtocolParameterUpdates;
  final int epoch;
  const Update(
      {required this.proposedProtocolParameterUpdates, required this.epoch});
  factory Update.fromCborBytes(List<int> cborBytes) {
    return Update.deserialize(
        CborObject.fromCbor(cborBytes).as<CborListValue>("Update"));
  }
  factory Update.deserialize(CborListValue cbor) {
    return Update(
        epoch: cbor.elementAt<CborIntValue>(1).toInt(),
        proposedProtocolParameterUpdates:
            ProposedProtocolParameterUpdates.deserialize(cbor
                .elementAt<CborObject>(0)
                .asMap("ProposedProtocolParameterUpdates")));
  }
  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
        epoch: json['epoch'],
        proposedProtocolParameterUpdates:
            ProposedProtocolParameterUpdates.fromJson(
                json['proposed_protocol_parameter_updates']));
  }
  Update copyWith(
      {ProposedProtocolParameterUpdates? proposedProtocolParameterUpdates,
      int? epoch}) {
    return Update(
        proposedProtocolParameterUpdates: proposedProtocolParameterUpdates ??
            this.proposedProtocolParameterUpdates,
        epoch: epoch ?? this.epoch);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      proposedProtocolParameterUpdates.toCbor(),
      CborUnsignedValue.u32(epoch)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposed_protocol_parameter_updates':
          proposedProtocolParameterUpdates.toJson(),
      'epoch': epoch
    };
  }
}

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

import 'voting_proposal.dart';

class VotingProposalSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const VotingProposalSerializationConfig(
      {this.encoding = CborIterableEncodingType.set, this.tags});

  factory VotingProposalSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return VotingProposalSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

class VotingProposals with ADASerialization {
  final List<VotingProposal> proposals;
  final VotingProposalSerializationConfig serializationConfig;
  VotingProposals(List<VotingProposal> proposals,
      {this.serializationConfig = const VotingProposalSerializationConfig()})
      : proposals = proposals.immutable;
  factory VotingProposals.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("proposals");
      final list = tag.valueAs<CborIterableObject>('proposals');
      return VotingProposals(
          list
              .valueAsListOf<CborListValue>("proposals")
              .map((e) => VotingProposal.deserialize(e))
              .toList(),
          serializationConfig: VotingProposalSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('proposals');
    return VotingProposals(
        list
            .valueAsListOf<CborListValue>("proposals")
            .map((e) => VotingProposal.deserialize(e))
            .toList(),
        serializationConfig:
            VotingProposalSerializationConfig(encoding: list.encoding));
  }
  factory VotingProposals.fromJson(Map<String, dynamic> json) {
    return VotingProposals(
        (json["proposals"] as List)
            .map((e) => VotingProposal.fromJson(e))
            .toList(),
        serializationConfig: VotingProposalSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              proposals.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(
              proposals.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(proposals.map((e) => e.toCbor()));
      }
    }() as CborObject;
    final tags = serializationConfig.tags;
    if (tags != null) {
      return CborTagValue(obj, tags);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "proposals": proposals.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

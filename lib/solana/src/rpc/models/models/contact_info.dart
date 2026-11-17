import 'package:on_chain/solana/src/address/sol_address.dart';

///  Information describing a cluster node
class ContactInfo {
  const ContactInfo({
    required this.pubkey,
    required this.gossip,
    required this.tpu,
    required this.rpc,
    required this.version,
    this.tpuQuic,
    this.tpuForwards,
    this.tpuForwardsQuic,
    this.tpuVote,
    this.tvu,
    this.pubsub,
    this.serveRepair,
    this.shredVersion,
    this.featureSet,
    this.clientId,
  });
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      pubkey: SolAddress.unchecked(json['pubkey']),
      gossip: json['gossip'],
      tpu: json['tpu'],
      rpc: json['rpc'],
      version: json['version'],
      tpuQuic: json['tpuQuic'],
      tpuForwards: json['tpuForwards'],
      tpuForwardsQuic: json['tpuForwardsQuic'],
      tpuVote: json['tpuVote'],
      tvu: json['tvu'],
      pubsub: json['pubsub'],
      serveRepair: json['serveRepair'],
      shredVersion: json['shredVersion'],
      featureSet: json['featureSet'],
      clientId: json['clientId'],
    );
  }

  /// Identity public key of the node
  final SolAddress pubkey;

  /// Gossip network address for the node
  final String? gossip;

  /// TPU network address for the node
  final String? tpu;

  /// JSON RPC network address for the node
  final String? rpc;

  /// Software version of the node
  final String? version;

  /// TPU QUIC network address for the node
  final String? tpuQuic;

  /// TPU forwards network address for the node
  final String? tpuForwards;

  /// TPU forwards QUIC network address for the node
  final String? tpuForwardsQuic;

  /// TPU vote network address for the node
  final String? tpuVote;

  /// TVU network address for the node
  final String? tvu;

  /// Pubsub network address for the node
  final String? pubsub;

  /// Serve repair network address for the node
  final String? serveRepair;

  /// Shred version of the node
  final int? shredVersion;

  /// Feature set of the node
  final int? featureSet;

  /// Client id of the node (e.g. `Agave`)
  final String? clientId;
}

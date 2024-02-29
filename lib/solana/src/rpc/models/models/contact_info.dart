import 'package:on_chain/solana/src/address/sol_address.dart';

///  Information describing a cluster node
class ContactInfo {
  const ContactInfo(
      {required this.pubkey,
      required this.gossip,
      required this.tpu,
      required this.rpc,
      required this.version});
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
        pubkey: SolAddress.unchecked(json["pubkey"]),
        gossip: json["gossip"],
        tpu: json["tpu"],
        rpc: json["rpc"],
        version: json["version"]);
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
}

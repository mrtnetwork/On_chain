import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/block/models/header/leader_cert/models/header_leader_cert.dart';
import 'package:on_chain/ada/src/models/block/models/header/leader_cert/models/header_leader_cert_type.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/vrf_cert.dart';

class HeaderLeaderCertNonceAndLeader extends HeaderLeaderCert {
  final VRFCert nonceVrf;
  final VRFCert leaderVrf;
  const HeaderLeaderCertNonceAndLeader(
      {required this.nonceVrf, required this.leaderVrf});
  factory HeaderLeaderCertNonceAndLeader.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> currentJson =
        json[HeaderLeaderCertType.nonceAndLeader.name] ?? json;
    return HeaderLeaderCertNonceAndLeader(
        nonceVrf: VRFCert.fromJson(currentJson["nonce_vrf"]),
        leaderVrf: VRFCert.fromJson(currentJson["leader_vrf"]));
  }

  @override
  HeaderLeaderCertType get type => HeaderLeaderCertType.nonceAndLeader;

  @override
  List<CborObject> toCborObjects() {
    return [nonceVrf.toCbor(), leaderVrf.toCbor()];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'nonce_vrf': nonceVrf.toJson(),
        'leader_vrf': leaderVrf.toJson()
      }
    };
  }

  @override
  String toString() {
    return 'HeaderLeaderCertNonceAndLeader{nonceVrf: $nonceVrf, leaderVrf: $leaderVrf}';
  }
}

import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/header/leader_cert/header_leader_cert/header_leader_cert.dart';
import 'package:on_chain/ada/src/models/header/leader_cert/header_leader_cert/header_leader_cert_type.dart';
import 'package:on_chain/ada/src/models/header/header/vrf_cert.dart';

class HeaderLeaderCertNonceAndLeader extends HeaderLeaderCert {
  final VRFCert nonceVrf;
  final VRFCert leaderVrf;
  const HeaderLeaderCertNonceAndLeader(
      {required this.nonceVrf, required this.leaderVrf});

  @override
  HeaderLeaderCertType get type => HeaderLeaderCertType.nonceAndLeader;

  @override
  List<CborObject> toCborObjects() {
    return [nonceVrf.toCbor(), leaderVrf.toCbor()];
  }

  @override
  String toString() {
    return "HeaderLeaderCertNonceAndLeader{nonceVrf: $nonceVrf, leaderVrf: $leaderVrf}";
  }

  @override
  Map<String, dynamic> toJson() {
    return {"nonceVrf": nonceVrf.toJson(), "leaderVrf": leaderVrf.toJson()};
  }
}

import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/header/leader_cert/header_leader_cert/header_leader_cert.dart';
import 'package:on_chain/ada/src/models/header/leader_cert/header_leader_cert/header_leader_cert_type.dart';
import 'package:on_chain/ada/src/models/header/header/vrf_cert.dart';

class HeaderLeaderCertVrfResult extends HeaderLeaderCert {
  final VRFCert cert;
  const HeaderLeaderCertVrfResult(this.cert);

  @override
  HeaderLeaderCertType get type => HeaderLeaderCertType.vrfResult;

  @override
  List<CborObject> toCborObjects() {
    return [cert.toCbor()];
  }

  @override
  Map<String, dynamic> toJson() {
    return {"cert": cert.toJson()};
  }
}

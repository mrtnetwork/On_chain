import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/block/models/header/leader_cert/models/header_leader_cert.dart';
import 'package:on_chain/ada/src/models/block/models/header/leader_cert/models/header_leader_cert_type.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/vrf_cert.dart';

class HeaderLeaderCertVrfResult extends HeaderLeaderCert {
  final VRFCert vrfCert;
  const HeaderLeaderCertVrfResult(this.vrfCert);

  factory HeaderLeaderCertVrfResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> currentJson =
        json[HeaderLeaderCertType.vrfResult.name] ?? json;
    return HeaderLeaderCertVrfResult(VRFCert.fromJson(currentJson["vrf_cert"]));
  }

  @override
  HeaderLeaderCertType get type => HeaderLeaderCertType.vrfResult;

  @override
  List<CborObject> toCborObjects() {
    return [vrfCert.toCbor()];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'vrf_cert': vrfCert.toJson()}
    };
  }
}

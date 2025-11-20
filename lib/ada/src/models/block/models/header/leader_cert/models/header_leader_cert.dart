import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/block/models/header/leader_cert/models/header_leader_cert_type.dart';
import 'package:on_chain/ada/src/models/block/models/header/leader_cert/models/nonce_and_leader.dart';
import 'package:on_chain/ada/src/models/block/models/header/leader_cert/models/vrf_result.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/vrf_cert.dart';

abstract class HeaderLeaderCert with InternalCborSerialization {
  const HeaderLeaderCert();
  abstract final HeaderLeaderCertType type;
  factory HeaderLeaderCert.deserialize(CborListValue cbor) {
    if (cbor.value.length > 1) {
      return HeaderLeaderCertNonceAndLeader(
          nonceVrf: VRFCert.deserialize(cbor.elementAt<CborListValue>(0)),
          leaderVrf: VRFCert.deserialize(cbor.elementAt<CborListValue>(1)));
    }
    return HeaderLeaderCertVrfResult(
        VRFCert.deserialize(cbor.elementAt<CborListValue>(0)));
  }
  factory HeaderLeaderCert.fromJson(Map<String, dynamic> json) {
    final type = HeaderLeaderCertType.fromName(json.keys.firstOrNull);
    switch (type) {
      case HeaderLeaderCertType.vrfResult:
        return HeaderLeaderCertVrfResult.fromJson(json[type.name]);
      case HeaderLeaderCertType.nonceAndLeader:
        return HeaderLeaderCertNonceAndLeader.fromJson(json[type.name]);
      default:
        throw ADAPluginException("Invalid HeaderLeaderCertType type.");
    }
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite(toCborObjects());
  }

  List<CborObject> toCborObjects();
}

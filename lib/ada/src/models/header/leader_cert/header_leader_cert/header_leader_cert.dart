import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/header/leader_cert/header_leader_cert/header_leader_cert_type.dart';
import 'package:on_chain/ada/src/models/header/leader_cert/models/header_leader_cert_leader_nonce.dart';
import 'package:on_chain/ada/src/models/header/leader_cert/models/header_leader_cert_vrf.dart';
import 'package:on_chain/ada/src/models/header/header/vrf_cert.dart';

abstract class HeaderLeaderCert with ADASerialization {
  const HeaderLeaderCert();
  abstract final HeaderLeaderCertType type;
  factory HeaderLeaderCert.deserialize(CborListValue cbor) {
    if (cbor.value.length > 1) {
      return HeaderLeaderCertNonceAndLeader(
          nonceVrf: VRFCert.deserialize(cbor.getIndex(0)),
          leaderVrf: VRFCert.deserialize(cbor.getIndex(1)));
    }
    return HeaderLeaderCertVrfResult(VRFCert.deserialize(cbor.getIndex(0)));
  }
  @override
  CborObject toCbor() {
    return CborListValue.fixedLength(toCborObjects());
  }

  List<CborObject> toCborObjects();
}

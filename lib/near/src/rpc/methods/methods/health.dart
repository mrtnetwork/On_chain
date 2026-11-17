import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/near/src/rpc/core/core.dart';

class NearNodeRequestHealth extends NearNodeRequest<dynamic, dynamic> {
  const NearNodeRequestHealth();
  @override
  String get method => "health";

  @override
  dynamic params() => null;

  @override
  ServiceReponseEncoding get responseEncoding => ServiceReponseEncoding.json;
}

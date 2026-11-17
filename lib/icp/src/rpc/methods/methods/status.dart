import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/service/http/http.dart';
import 'package:on_chain/icp/src/utils/utils.dart';

class ICPRequestStatus extends ICPRequest<ICPHttpStatusResponse> {
  final ICPApiVersion version;

  const ICPRequestStatus({this.version = ICPApiVersion.v2});

  @override
  String get path {
    return ICPUtils.statusPath(version: version);
  }

  @override
  Future<List<int>?> body() async => null;

  @override
  ICPHttpStatusResponse onResponse(List<int> result) {
    return ICPHttpStatusResponse.deserialize(result);
  }

  @override
  RequestMethod get requestMethod => RequestMethod.get;
}

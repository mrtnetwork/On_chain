import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalValidatorsOrdered
    extends
        NearNodeRequest<
          List<NearRpcValidatorStakeView>,
          List<Map<String, dynamic>>
        > {
  final NearRpcRpcValidatorsOrderedRequest args;
  const NearNodeRequestExperimentalValidatorsOrdered(this.args);
  @override
  String get method => "EXPERIMENTAL_validators_ordered";

  @override
  dynamic params() => args.toJson();

  @override
  List<NearRpcValidatorStakeView> onResponse(
    List<Map<String, dynamic>> result,
  ) {
    return result.map((e) => NearRpcValidatorStakeView.fromJson(e)).toList();
  }

  @override
  ServiceReponseEncoding get responseEncoding =>
      ServiceReponseEncoding.listOfMap;
}

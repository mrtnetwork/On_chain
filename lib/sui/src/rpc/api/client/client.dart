import 'package:blockchain_utils/service/service.dart';
import 'package:on_chain/sui/src/rpc/api/api/api.dart';
import 'package:on_chain/sui/src/rpc/core/request.dart';

abstract class SuiQuickClient with SuiQuickClientApi {
  const SuiQuickClient();
}

class DefaultSuiQuickClient extends SuiQuickClient {
  @override
  final IGrpcProvider<
    IServiceProvider,
    BaseSuiServiceRequestParams,
    BaseGRPCServiceRequestParams
  >
  provider;
  const DefaultSuiQuickClient({required this.provider});
}

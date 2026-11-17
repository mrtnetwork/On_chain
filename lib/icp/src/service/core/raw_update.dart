import 'package:on_chain/icp/src/service/core/service.dart';

class RawIcpUpdateCall extends IICPUpdateMessage<List<int>> {
  @override
  final String methodName;
  final List<int> arg;
  const RawIcpUpdateCall({required this.methodName, required this.arg});

  @override
  List<int> onResponse(List<int> candidBytes) => candidBytes;

  @override
  List<int> toCandidBytes() => arg;
}

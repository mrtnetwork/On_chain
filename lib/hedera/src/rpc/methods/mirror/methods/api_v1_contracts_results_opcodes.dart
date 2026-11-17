import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/contracts/results/{transactionIdOrHash}/opcodes
class HederaMirrorRequestGetContractOpcodes
    extends
        HederaMirrorRequest<
          HederaMirrorTypesOpcodesResponse,
          Map<String, dynamic>
        > {
  final String transactionIdOrHash;
  final bool? stack;
  final bool? memory;
  final bool? storage;

  const HederaMirrorRequestGetContractOpcodes({
    required this.transactionIdOrHash,
    this.stack,
    this.memory,
    this.storage,
  });

  @override
  String? get path => '/api/v1/contracts/results/$transactionIdOrHash/opcodes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'stack': stack?.toString(),
    'memory': memory?.toString(),
    'storage': storage?.toString(),
  };

  @override
  HederaMirrorTypesOpcodesResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesOpcodesResponse.fromJson(result);
  }
}

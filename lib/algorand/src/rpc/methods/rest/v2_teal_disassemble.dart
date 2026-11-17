// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// POST /v2/teal/disassemble
class AlgoRestRequestTealDisassemble
    extends
        AlgoRestRequest<
          AlgoRestTypesDisassembleResponse,
          Map<String, dynamic>
        > {
  final BuBytes source;

  AlgoRestRequestTealDisassemble({required List<int> source}) : source = source.asImmutableBytes;

  @override
  String get path => '/v2/teal/disassemble';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  BuBytes body() => source;

  @override
  AlgoRestTypesDisassembleResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesDisassembleResponse.fromJson(result);
  }
}

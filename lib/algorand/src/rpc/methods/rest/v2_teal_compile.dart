// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// POST /v2/teal/compile
class AlgoRestRequestTealCompile
    extends
        AlgoRestRequest<AlgoRestTypesCompileResponse, Map<String, dynamic>> {
  final bool? sourcemap;
  final BuBytes source;

  AlgoRestRequestTealCompile({this.sourcemap, required List<int> source}) : source = source.asImmutableBytes;

  @override
  String get path => '/v2/teal/compile';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'sourcemap': sourcemap?.toString(),
  };

  @override
  BuBytes body() => source;

  @override
  AlgoRestTypesCompileResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesCompileResponse.fromJson(result);
  }
}

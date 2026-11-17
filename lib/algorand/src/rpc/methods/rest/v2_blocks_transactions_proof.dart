// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/blocks/{round}/transactions/{txid}/proof
class AlgoRestRequestGetTransactionProof
    extends
        AlgoRestRequest<AlgoRestTypesTransactionProof, Map<String, dynamic>> {
  final BigInt round;
  final String txid;
  final String? hashtype;
  @override
  final RequestFormat? responseFormat;

  const AlgoRestRequestGetTransactionProof({
    required this.round,
    required this.txid,
    this.hashtype,
    this.responseFormat,
  });

  @override
  String get path => '/v2/blocks/$round/transactions/$txid/proof';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'hashtype': hashtype,
    'format': responseFormat?.name,
  };

  @override
  AlgoRestTypesTransactionProof onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesTransactionProof.fromJson(result);
  }
}

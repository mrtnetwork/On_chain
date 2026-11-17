import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';
import 'package:on_chain/tezos/src/rpc/types/types/types.dart';

/// GET /chains/{chain_id}/blocks/{block_id}/operations/{list_offset}/{operation_offset}
class OctezUshuaiaRequestOperationsContentsListOffsetOperationOffset
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaOperationProtocolChainIdHashBranchAndContents,
          dynamic
        > {
  final int listOffset;
  final int operationOffset;
  final String version;
  final String? forceMetadata;
  final String? metadata;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationsContentsListOffsetOperationOffset({
    required this.listOffset,
    required this.operationOffset,
    required this.version,
    this.forceMetadata,
    this.metadata = "always",
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operations/$listOffset/$operationOffset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'force_metadata': forceMetadata,
    'metadata': metadata,
  };

  @override
  OctezUshuaiaOperationProtocolChainIdHashBranchAndContents onResponse(
    dynamic result,
  ) {
    return OctezUshuaiaOperationProtocolChainIdHashBranchAndContents.fromJson(
      result,
    );
  }
}

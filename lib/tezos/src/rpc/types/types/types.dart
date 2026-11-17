import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/tezos/src/rpc/types/types/ushuaia.dart';

class OctezUshuaiaOperationProtocolChainIdHashBranchAndContents {
  final OctezUshuaiaProtocolHash protocol;
  final OctezUshuaiaChainId chainId;
  final OctezUshuaiaOperationHash hash;
  final OctezUshuaiaBlockHash branch;
  final OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadata contents;

  const OctezUshuaiaOperationProtocolChainIdHashBranchAndContents({
    required this.protocol,
    required this.chainId,
    required this.hash,
    required this.branch,
    required this.contents,
  });

  factory OctezUshuaiaOperationProtocolChainIdHashBranchAndContents.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezUshuaiaOperationProtocolChainIdHashBranchAndContents(
      protocol: OctezUshuaiaProtocolHash.fromJson(json['protocol']),
      chainId: OctezUshuaiaChainId.fromJson(json['chain_id']),
      hash: OctezUshuaiaOperationHash.fromJson(json['hash']),
      branch: OctezUshuaiaBlockHash.fromJson(json['branch']),
      contents:
          OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadata.fromJson(
            json,
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'protocol': protocol.toJson(),
        'chain_id': chainId.toJson(),
        'hash': hash.toJson(),
        'branch': branch.toJson(),
        'contents': contents.toJson(),
      }.notNullValue;
}

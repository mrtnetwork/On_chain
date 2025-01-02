import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns information about all the nodes participating in the clusterot
/// https://solana.com/docs/rpc/http/getclusternodes
class SolanaRequestGetClusterNodes
    extends SolanaRequest<List<ContactInfo>, List> {
  /// getClusterNodes
  @override
  String get method => SolanaRequestMethods.getClusterNodes.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  List<ContactInfo> onResonse(List result) {
    return result.map((e) => ContactInfo.fromJson(e)).toList();
  }
}

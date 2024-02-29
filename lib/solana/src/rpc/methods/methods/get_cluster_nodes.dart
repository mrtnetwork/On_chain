import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns information about all the nodes participating in the clusterot
/// https://solana.com/docs/rpc/http/getclusternodes
class SolanaRPCGetClusterNodes extends SolanaRPCRequest<List<ContactInfo>> {
  /// getClusterNodes
  @override
  String get method => SolanaRPCMethods.getClusterNodes.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  List<ContactInfo> onResonse(result) {
    return (result as List).map((e) => ContactInfo.fromJson(e)).toList();
  }
}

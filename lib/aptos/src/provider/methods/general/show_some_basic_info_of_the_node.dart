import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

/// Show some basic info of the node.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestShowSomeBasicInfoOfTheNode
    extends AptosRequest<String, Map<String, dynamic>> {
  AptosRequestShowSomeBasicInfoOfTheNode();

  @override
  String get method => AptosApiMethod.showSomeBasicInfoOfTheNode.url;

  @override
  String onResonse(Map<String, dynamic> result) {
    return result["message"];
  }
}

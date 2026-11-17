import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Retrieves the bytecode of a contract by its bytecode hash.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getbytecodebyhash)
class ZKSRequestGetByteCodeByHash
    extends EthereumRequest<List<int>, List<int>> {
  final String hash;
  const ZKSRequestGetByteCodeByHash(this.hash);
  @override
  String get method => "zks_getbytecodebyhash";
  @override
  List<dynamic> toJson() {
    return [hash];
  }
}

import 'package:blockchain_utils/blockchain_utils.dart';

abstract mixin class EthereumSigner {
  Future<ETHSignature> signAsync(List<int> message, {bool hashMessage = true});
  Future<List<int>> signPersonalMessageAsync(List<int> message,
      {int? payloadLength});
}

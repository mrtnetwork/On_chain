import 'package:on_chain/ethereum/ethereum.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('personal sign', () {
    const String correctSig =
        '4b57a6ca5e2f5da5ae9667d69bb61285808b54ed08dacc76d77b02a8e6f6be905bf4f6fce63ff4142af25458c3bb8ecbda4990b76783a35561382096e30082321b';

    final privateKey = ETHPrivateKey(
        'cd23c9f2e2c096ee3be3c4e0e58199800c0036ea27b7cd4e838bbde8b21788b3');
    final message =
        BytesUtils.fromHexString('0x84df2267aa318f451199223385516162');
    final sign = privateKey.signPersonalMessage(message);
    final publicKey = privateKey.publicKey();
    final verify = publicKey.verifyPersonalMessage(message, sign);
    final recoverPubKey = ETHPublicKey.getPublicKey(message, sign);
    expect(recoverPubKey?.toHex(), publicKey.toHex());
    expect(sign, BytesUtils.fromHexString(correctSig));
    expect(verify, true);
    const String correctSig2 =
        'b4842130697a77bfd1bf3b09f7fa7d489320a86cbf6308627f2dcecd3e21ebe95a9a74af066d4c26263527ad3c7e73adbe62f0d16f2cacf5a8b5c3d816ce996f1b';
    final privateKey2 = ETHPrivateKey(
        'abfbd6391f206365d75b171bbe5efea6a7cbfff143d5fc83bdcb61e4ab8aa0f9');
    final sign2 = privateKey2.signPersonalMessage(message);
    final publicKey2 = privateKey2.publicKey();
    final verify2 = publicKey2.verifyPersonalMessage(message, sign2);
    expect(sign2, BytesUtils.fromHexString(correctSig2));
    expect(verify2, true);
    final recoverPubKey2 = ETHPublicKey.getPublicKey(message, sign2);
    expect(recoverPubKey2?.toHex(), publicKey2.toHex());
  });
}

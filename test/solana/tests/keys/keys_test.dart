import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  test('test1', () {
    final privateKey = SolanaPrivateKey.fromSeed(BytesUtils.fromHexString(
        '4e27902b3df33d7857dc9d218a3b34a6550e9c7621a6d601d06240a517d22017'));
    final address = privateKey.publicKey().toAddress();
    final privateKey2 = SolanaPrivateKey.fromSeed(BytesUtils.fromHexString(
        '180924a2160def1027f68a5e5ddf2cde42772491d4b7ac95c91ffe9c0b701368'));
    final address2 = privateKey2.publicKey().toAddress();
    final messageBytes = BytesUtils.fromHexString(
        '80020001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bfcd54c224b4612dfabe51d71efd60f1bd4a59bb30e7b2a3dda5f929c7c92e131c000000000000000000000000000000000000000000000000000000000000000059e37b352d6f49f172ac3ad79c99db83769f64adbd030834876518b3bf54135c0102020001340000000080b2e60e00000000c800000000000000000000000000000000000000000000000000000000000000000000000000000000');
    final sig1 = privateKey.sign(messageBytes);
    final sig2 = privateKey2.sign(messageBytes);
    expect(address.address, '527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA');
    expect(address2.address, 'EpXYFSYy97dzijvNGChDW3DidjtiV8EnDiEdtrPbgUew');
    expect(BytesUtils.toHexString(sig1),
        'de7a66c57762a2084d09c6af8992537564a4f05fbd30404885c4305ce5719af8de5f0524a137dac463aa8f839d6f848edd54567d614500459c51661240bccc0e');
    expect(BytesUtils.toHexString(sig2),
        '9fdade1202d72a1cb002768793a1498f625a1de7a57c3edd8be082eaa1eb0bd0a5d4d143ade851c4d0b429223e7247772b79b0bfc5b51cc572b740b13a82f707');
  });
}

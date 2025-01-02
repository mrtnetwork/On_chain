import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group('tokenEntangler', () {
    _entangledPair();
    _createEntangledPair();
    _swap();
    _updateEntangledPair();
  });
}

void _createEntangledPair() {
  test('createEntangledPair', () {
    final layout = MetaplexTokenEntanglerCreateEntangledPairLayout(
        bump: 1,
        reverseBump: 1,
        tokenAEscrowBump: 1,
        tokenBEscrowBump: 1,
        price: BigInt.from(1111111),
        paysEveryTime: true);
    expect(layout.toHex(), 'a66a202d9cd2d1f00101010147f410000000000001');
    final decode = MetaplexTokenEntanglerCreateEntangledPairLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _swap() {
  test('swap', () {
    const layout = MetaplexTokenEntanglerSwapLayout();
    expect(layout.toHex(), 'f8c69e91e17587c8');
    final decode =
        MetaplexTokenEntanglerSwapLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _updateEntangledPair() {
  test('updateEntangledPair', () {
    final layout = MetaplexTokenEntanglerUpdateEntangledPairLayout(
        paysEveryTime: false, price: BigInt.from(12));
    expect(layout.toHex(), '2961f7da62a24bf40c0000000000000000');
    final decode = MetaplexTokenEntanglerUpdateEntangledPairLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _entangledPair() {
  const owner =
      SolAddress.unchecked('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
  test('EntangledPair', () {
    final layout = EntangledPair(
        treasuryMint: owner,
        mintA: owner,
        mintB: owner,
        tokenAEscrow: owner,
        tokenBEscrow: owner,
        authority: owner,
        bump: 1,
        tokenAEscrowBump: 2,
        tokenBEscrowBump: 3,
        price: BigInt.from(444444444),
        paid: false,
        paysEveryTime: true);
    expect(layout.toHex(),
        '857614d20136ac74f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760102031caf7d1a000000000001');
    final decode = EntangledPair.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

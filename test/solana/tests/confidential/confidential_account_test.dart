import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

/// Confidential transfer account state parsing (pure Dart, no backend).
/// Layout: base 165 bytes + account-type byte + TLV
/// (u16 type || u16 len || 295-byte state).
void confidentialAccountTest() {
  group('Solana/Confidential Transfer', () {
  List<int> buildAccountBytes() {
    // Base token account (165 zero bytes suffice for the parser) +
    // account-type byte (2 = Account) + TLV extension type 5, len 295.
    final base = List<int>.filled(165, 0);
    const typeByte = [2];
    const extType = [5, 0]; // u16 LE = 5
    const extLen = [0x27, 0x01]; // u16 LE = 295
    final state = List<int>.filled(295, 0);
    // approved = true, elgamal pubkey marker, counters.
    state[0] = 1;
    for (var i = 0; i < 32; i++) {
      state[1 + i] = i + 1;
    }
    // decryptable balance marker bytes.
    for (var i = 0; i < 36; i++) {
      state[1 + 32 + 192 + i] = 0xA0 + i;
    }
    state[1 + 32 + 192 + 36] = 1; // allowConfidentialCredits
    state[1 + 32 + 192 + 36 + 1] = 1; // allowNonConfidentialCredits
    // pendingBalanceCreditCounter = 7 (LE u64 at offset 263).
    state[263] = 7;
    return [...base, ...typeByte, ...extType, ...extLen, ...state];
  }

  test('confidential state parses with 295-byte span', () {
    expect(ConfidentialTransferAccount.size, 295);
    final blob = buildAccountBytes();
    final state = ConfidentialTransferAccount.fromAccountBytes(blob);
    expect(state.approved, isTrue);
    expect(state.elgamalPubkey, hasLength(32));
    expect(state.elgamalPubkey.first, 1);
    expect(state.pendingBalanceLo, hasLength(64));
    expect(state.pendingBalanceHi, hasLength(64));
    expect(state.availableBalance, hasLength(64));
    expect(state.decryptableAvailableBalance, hasLength(36));
    expect(state.allowConfidentialCredits, isTrue);
    expect(state.allowNonConfidentialCredits, isTrue);
    expect(state.pendingBalanceCreditCounter, BigInt.from(7));
    // Serialize round-trips through the same layout.
    expect(state.layout.span, 295);
  });

  test('missing extension throws', () {
    expect(
      () => ConfidentialTransferAccount.fromAccountBytes(
        List<int>.filled(170, 0),
      ),
      throwsA(anything),
    );
  });

  test('decryptable seed is 36 zero bytes', () {
    expect(SolanaConfidentialZkUtils.decryptableZeroBalanceSeed(), hasLength(36));
    expect(SolanaConfidentialZkUtils.aeCiphertextLen, 36);
    expect(SolanaConfidentialZkUtils.pendingHiShift, 16);
    final balances = SolanaConfidentialBalances(
      pendingLo: BigInt.from(0xABCD),
      pendingHi: BigInt.from(2),
      available: BigInt.from(42),
    );
    expect(balances.pendingTotal, BigInt.from(0xABCD) + (BigInt.from(2) << 16));
  });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(confidentialAccountTest, 'Confidential');
}

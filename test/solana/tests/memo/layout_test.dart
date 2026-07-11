import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('Memo layout', () {
    _stringRoundTrip();
    _byteLevel();
    _nonAscii();
    _rawBytesLossless();
    _immutable();
    _memoGetter();
    _empty();
    _jsonConsistency();
  });
}

void _stringRoundTrip() {
  test('string round-trip preserves hex-looking memos', () {
    const memos = [
      '1234',
      'DEAD',
      'DEADBEEF',
      'cafe',
      '0xabcd',
      '0XABCD',
      'Hello, Solana!',
      'https://example.com/path?a=1&b=2',
      'mixedCase123',
    ];
    for (final memo in memos) {
      final encoded = MemoLayout.fromString(memo).toBytes();
      final decoded = MemoLayout.fromBuffer(encoded);
      expect(
        decoded.memo,
        memo,
        reason: 'fromBuffer(fromString(x)).memo must equal x for "$memo"',
      );
    }
  });
}

void _byteLevel() {
  test('encodes hex-looking memo as UTF-8 bytes, not raw hex', () {
    // "1234" must be the four ASCII code points, not [0x12, 0x34].
    expect(MemoLayout.fromString('1234').toBytes(), [0x31, 0x32, 0x33, 0x34]);
    // "DEAD" must be the ASCII bytes, not [0xDE, 0xAD].
    expect(MemoLayout.fromString('DEAD').toBytes(), [0x44, 0x45, 0x41, 0x44]);
  });
}

void _nonAscii() {
  test('encodes multi-byte characters as UTF-8 and round-trips', () {
    // 'é' (U+00E9) must be the two-byte UTF-8 sequence, proving UTF-8 (not
    // Latin-1/ASCII) is used.
    expect(MemoLayout.fromString('é').toBytes(), [0xC3, 0xA9]);
    const memos = ['привет 🚀', 'café', '日本語'];
    for (final memo in memos) {
      final decoded = MemoLayout.fromBuffer(
        MemoLayout.fromString(memo).toBytes(),
      );
      expect(decoded.memo, memo);
    }
  });
}

void _rawBytesLossless() {
  test('preserves arbitrary non-UTF-8 bytes losslessly', () {
    // 0xBE is a stray UTF-8 continuation byte: decoding to a String and back
    // would corrupt it. Storing bytes must round-trip exactly.
    const raw = [0xDE, 0xAD, 0xBE, 0xEF];
    expect(MemoLayout.fromBuffer(raw).toBytes(), raw);
    expect(MemoLayout(memoBytes: raw).toBytes(), raw);
  });
}

void _immutable() {
  test('is unaffected by mutating the source list or the toBytes() result', () {
    final source = [0x44, 0x45, 0x41, 0x44]; // "DEAD"
    final layout = MemoLayout.fromBuffer(source);
    source[0] = 0x00; // mutating the input must not leak in
    expect(layout.toBytes(), [0x44, 0x45, 0x41, 0x44]);
    // toBytes() must not expose a mutable view of the internal bytes.
    expect(() => layout.toBytes()[0] = 0x00, throwsUnsupportedError);
  });
}

void _memoGetter() {
  test('memo getter decodes non-UTF-8 bytes best-effort without throwing', () {
    final layout = MemoLayout.fromBuffer([0xDE, 0xAD, 0xBE, 0xEF]);
    // Lossy by design (replacement chars), but must not throw and must leave
    // the authoritative bytes untouched.
    expect(() => layout.memo, returnsNormally);
    expect(layout.toBytes(), [0xDE, 0xAD, 0xBE, 0xEF]);
  });
}

void _empty() {
  test('handles an empty memo', () {
    expect(MemoLayout.fromString('').toBytes(), <int>[]);
    expect(MemoLayout.fromBuffer(<int>[]).memo, '');
  });
}

void _jsonConsistency() {
  test('toJson shows valid UTF-8 as text and non-UTF-8 as hex', () {
    // Valid UTF-8 round-trips as a readable string.
    expect(MemoLayout.fromString('Hello').toJson(), {'memo': 'Hello'});
    // Non-UTF-8 bytes fall back to a 0x hex string instead of being corrupted.
    final raw = MemoLayout.fromBuffer([0xDE, 0xAD, 0xBE, 0xEF]);
    expect(raw.toJson(), {'memo': '0xdeadbeef'});
  });
}

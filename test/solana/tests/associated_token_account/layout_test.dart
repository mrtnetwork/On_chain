import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group("associatedToken", () {
    _associatedToken();
    _associatedTokenAccountIdempotent();
    _recoverNested();
  });
}

void _associatedToken() {
  test("associatedTokenAccount", () {
    const layout = AssociatedTokenAccountProgramInitializeLayout();
    expect(layout.toBytes(), []);
    final decode = AssociatedTokenAccountProgramInitializeLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _associatedTokenAccountIdempotent() {
  test("associatedTokenAccountIdempotent", () {
    const layout = AssociatedTokenAccountProgramIdempotentLayout();
    expect(layout.toHex(), "01");
    final decode = AssociatedTokenAccountProgramIdempotentLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _recoverNested() {
  test("recoverNested", () {
    const layout = AssociatedTokenAccountProgramRecoverNestedLayout();
    expect(layout.toHex(), "02");
    final decode = AssociatedTokenAccountProgramRecoverNestedLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

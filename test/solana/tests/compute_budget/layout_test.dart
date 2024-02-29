import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group("ComputeBudget layout", () {
    _requestHeap();
    _requestUnits();
    _unitLimit();
    _unitPrice();
  });
}

void _requestHeap() {
  test("request heap frame", () {
    final layout = ComputeBudgetRequestHeapFrameLayout(bytes: 12);
    expect(layout.toHex(), "010c000000");
    final decode =
        ComputeBudgetRequestHeapFrameLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _requestUnits() {
  test("request units", () {
    final layout =
        ComputeBudgetRequestUnitsLayout(additionalFee: 1, units: 100);
    expect(layout.toHex(), "006400000001000000");
    final decode = ComputeBudgetRequestUnitsLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _unitLimit() {
  test("unit limit", () {
    final layout = ComputeBudgetSetComputeUnitLimitLayout(units: 50);
    expect(layout.toHex(), "0232000000");
    final decode =
        ComputeBudgetSetComputeUnitLimitLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _unitPrice() {
  test("unit price", () {
    final layout = ComputeBudgetSetComputeUnitPriceLayout(
        microLamports: BigInt.from(100000000));
    expect(layout.toHex(), "0300e1f50500000000");
    final decode =
        ComputeBudgetSetComputeUnitPriceLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _testEntry();
}

void _testEntry() {
  test("Entry Function serialization", () {
    final function = AptosTransactionEntryFunction(
        moduleId: AptosModuleId(address: AptosAddress.one, name: "account"),
        functionName: "regiester",
        typeArgs: [],
        args: [
          MoveU128(BigInt.parse("2500000000000")),
          MoveU256(BigInt.parse("2500000000000")),
          AptosAddress.one
        ]);

    expect(function.toBcsHex(),
        "0000000000000000000000000000000000000000000000000000000000000001076163636f756e740972656769657374657200031000a89c134602000000000000000000002000a89c1346020000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001");
    final decode = AptosTransactionEntryFunction.deserialize(function.toBcs());
    expect(decode.toBcs(), function.toBcs());
    expect(decode.functionName, function.functionName);
    expect(decode.moduleId, function.moduleId);
    expect(decode.typeArgs, function.typeArgs);
  });
  test("Entry Function serialization 2", () {
    final function = AptosTransactionEntryFunction(
        moduleId: AptosModuleId(address: AptosAddress.one, name: "account"),
        functionName: "regiester",
        typeArgs: [
          AptosTypeTagGeneric(32),
          AptosTypeTagVector(AptosTypeTagVector(AptosTypeTagGeneric(12))),
          AptosTypeTagSigner(),
          AptosTypeTagAddress()
        ],
        args: [
          MoveU128(BigInt.parse("2500000000000")),
          MoveU256(BigInt.parse("2500000000000")),
          AptosAddress.one,
          MoveBool(false),
          MoveU8Vector(List<int>.filled(16, 12)),
          MoveU16(100)
        ]);
    expect(function.toBcsHex(),
        "0000000000000000000000000000000000000000000000000000000000000001076163636f756e740972656769657374657204ff01200000000606ff010c0000000504061000a89c134602000000000000000000002000a89c1346020000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001010011100c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c026400");
    final decode = AptosTransactionEntryFunction.deserialize(function.toBcs());
    expect(decode.toBcs(), function.toBcs());
    expect(decode.functionName, function.functionName);
    expect(decode.moduleId, function.moduleId);
    expect(decode.typeArgs, function.typeArgs);
  });

  test("Serialization transcation payload entry function", () {
    final function = AptosTransactionEntryFunction(
        moduleId: AptosModuleId(address: AptosAddress.one, name: "account"),
        functionName: "regiester",
        typeArgs: [
          AptosTypeTagGeneric(32),
          AptosTypeTagVector(AptosTypeTagVector(AptosTypeTagGeneric(12))),
          AptosTypeTagSigner(),
          AptosTypeTagAddress()
        ],
        args: [
          MoveU128(BigInt.parse("2500000000000")),
          MoveU256(BigInt.parse("2500000000000")),
          AptosAddress.one,
          MoveBool(false),
          MoveU8Vector(List<int>.filled(16, 12)),
          MoveU16(100)
        ]);

    expect(function.toBcsHex(),
        "0000000000000000000000000000000000000000000000000000000000000001076163636f756e740972656769657374657204ff01200000000606ff010c0000000504061000a89c134602000000000000000000002000a89c1346020000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001010011100c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c026400");
    final decode = AptosTransactionEntryFunction.deserialize(function.toBcs());
    expect(decode.toBcs(), function.toBcs());
    expect(decode.functionName, function.functionName);
    expect(decode.moduleId, function.moduleId);
    expect(decode.typeArgs, function.typeArgs);
    final payload =
        AptosTransactionPayloadEntryFunction(entryFunction: function);
    expect(payload.toVariantBcsHex(),
        "020000000000000000000000000000000000000000000000000000000000000001076163636f756e740972656769657374657204ff01200000000606ff010c0000000504061000a89c134602000000000000000000002000a89c1346020000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001010011100c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c026400");
    final decodePayload =
        AptosTransactionPayloadEntryFunction.deserialize(payload.toBcs());
    expect(decodePayload.toBcsHex(), payload.toBcsHex());
    expect(decodePayload.toVariantBcsHex(), payload.toVariantBcsHex());
  });
}

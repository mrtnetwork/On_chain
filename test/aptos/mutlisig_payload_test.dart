import 'package:test/test.dart';
import 'package:on_chain/on_chain.dart';

void main() {
  _test();
}

void _test() {
  test("Multisig transaction payload serialization", () {
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
    final multisigPayload =
        AptosMultisigTransactionPayloadEntryFunction(entryFunction: function);
    final multisig = AptosMultisig(
        multisigAddress: AptosAddress.one, transactionPayload: multisigPayload);
    final payload = AptosTransactionPayloadMultisig(multisig: multisig);
    expect(payload.toVariantBcsHex(),
        "03000000000000000000000000000000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000001076163636f756e740972656769657374657204ff01200000000606ff010c0000000504061000a89c134602000000000000000000002000a89c1346020000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001010011100c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c026400");
    final decodePayload =
        AptosTransactionPayloadMultisig.deserialize(payload.toBcs());
    expect(decodePayload.toVariantBcs(), payload.toVariantBcs());
    expect(decodePayload.toBcs(), payload.toBcs());
  });
  test("Multisig transaction payload serialization 2", () {
    final multisig = AptosMultisig(multisigAddress: AptosAddress.one);
    final payload = AptosTransactionPayloadMultisig(multisig: multisig);
    expect(payload.toVariantBcsHex(),
        "03000000000000000000000000000000000000000000000000000000000000000100");
    final decodePayload =
        AptosTransactionPayloadMultisig.deserialize(payload.toBcs());
    expect(decodePayload.toVariantBcs(), payload.toVariantBcs());
    expect(decodePayload.multisig.transactionPayload, null);
    expect(decodePayload.toBcs(), payload.toBcs());
  });
}

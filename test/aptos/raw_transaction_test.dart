import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _script();
  _entryFunction();
  _multisig();
}

void _script() {
  test("Raw Transaction Script serialization", () {
    final script = AptosScript(byteCode: List<int>.filled(12, 32), typeArgs: [
      AptosTypeTagBoolean(),
      AptosTypeTagNumeric.u8(),
      AptosTypeTagNumeric.u16(),
      AptosTypeTagNumeric.u32(),
      AptosTypeTagNumeric.u64(),
      AptosTypeTagNumeric.u128(),
      AptosTypeTagNumeric.u256(),
      AptosTypeTagGeneric(32),
      AptosTypeTagVector(AptosTypeTagVector(AptosTypeTagGeneric(12))),
      AptosTypeTagSigner(),
      AptosTypeTagAddress(),
      AptosTypeTagStruct(AptosStructTag(
          address: AptosAddress.one,
          moduleName: "account",
          name: "coin",
          typeArgs: [
            AptosTypeTagAddress(),
          ]))
    ], arguments: [
      MoveU8(12),
      MoveU32(1 << 30),
      MoveU64(BigInt.parse("2500000000000")),
      MoveU128(BigInt.parse("2500000000000")),
      MoveU256(BigInt.parse("2500000000000")),
      AptosAddress.one,
      MoveSerialized.fromHex("0x01ff0120000000")
    ]);
    final payload = AptosTransactionPayloadScript(script: script);
    expect(payload.toVariantBcsHex(),
        "000c2020202020202020202020200c0001080902030aff01200000000606ff010c0000000504070000000000000000000000000000000000000000000000000000000000000001076163636f756e7404636f696e010407000c07000000400100a89c13460200000200a89c134602000000000000000000000800a89c1346020000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000001090701ff0120000000");
    final decode = AptosTransactionPayloadScript.deserialize(payload.toBcs());
    expect(decode.toBcsHex(), payload.toBcsHex());
    expect(payload, decode);
    final rawTx = AptosRawTransaction(
        sender: AptosAddress.two,
        sequenceNumber: BigInt.from(1),
        transactionPayload: decode,
        maxGasAmount: BigInt.from(60000000),
        gasUnitPrice: BigInt.from(100000),
        expirationTimestampSecs: BigInt.from(160000000),
        chainId: 1);
    expect(rawTx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000020100000000000000000c2020202020202020202020200c0001080902030aff01200000000606ff010c0000000504070000000000000000000000000000000000000000000000000000000000000001076163636f756e7404636f696e010407000c07000000400100a89c13460200000200a89c134602000000000000000000000800a89c1346020000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000001090701ff01200000000087930300000000a086010000000000006889090000000001");
    final decodeRawTx = AptosRawTransaction.deserialize(rawTx.toBcs());
    expect(decodeRawTx.toBcs(), rawTx.toBcs());
    // expect(rawTx, decodeRawTx);
  });
}

void _entryFunction() {
  test("Raw Transaction Entry Function serialization", () {
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
    final rawTx = AptosRawTransaction(
        sender: AptosAddress.one,
        sequenceNumber: BigInt.from(1),
        transactionPayload: decodePayload,
        maxGasAmount: BigInt.from(60000000),
        gasUnitPrice: BigInt.from(100000),
        expirationTimestampSecs: BigInt.from(160000000),
        chainId: 1);
    expect(rawTx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000010100000000000000020000000000000000000000000000000000000000000000000000000000000001076163636f756e740972656769657374657204ff01200000000606ff010c0000000504061000a89c134602000000000000000000002000a89c1346020000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001010011100c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0264000087930300000000a086010000000000006889090000000001");
    final decodeRawTx = AptosRawTransaction.deserialize(rawTx.toBcs());
    expect(decodeRawTx.toBcs(), rawTx.toBcs());
  });
}

void _multisig() {
  test("Raw Transaction Multisig serialization", () {
    final multisig = AptosMultisig(multisigAddress: AptosAddress.one);
    final payload = AptosTransactionPayloadMultisig(multisig: multisig);
    expect(payload.toVariantBcsHex(),
        "03000000000000000000000000000000000000000000000000000000000000000100");
    final decodePayload =
        AptosTransactionPayloadMultisig.deserialize(payload.toBcs());
    expect(decodePayload.toVariantBcs(), payload.toVariantBcs());
    expect(decodePayload.multisig.transactionPayload, null);
    expect(decodePayload.toBcs(), payload.toBcs());
    final rawTx = AptosRawTransaction(
        sender: AptosAddress.one,
        sequenceNumber: BigInt.from(100),
        transactionPayload: decodePayload,
        maxGasAmount: BigInt.from(60000000),
        gasUnitPrice: BigInt.from(100000),
        expirationTimestampSecs: BigInt.from(160000000),
        chainId: 0);
    expect(rawTx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000016400000000000000030000000000000000000000000000000000000000000000000000000000000001000087930300000000a086010000000000006889090000000000");
    final decodeRawTx = AptosRawTransaction.deserialize(rawTx.toBcs());
    expect(decodeRawTx.toBcs(), rawTx.toBcs());
  });
  test("Raw Transaction Multisig serialization 2", () {
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
    final rawTx = AptosRawTransaction(
        sender: AptosAddress.one,
        sequenceNumber: BigInt.from(100),
        transactionPayload: decodePayload,
        maxGasAmount: BigInt.from(60000000),
        gasUnitPrice: BigInt.from(100000),
        expirationTimestampSecs: BigInt.from(160000000),
        chainId: 0);
    expect(rawTx.toBcsHex(),
        "0000000000000000000000000000000000000000000000000000000000000001640000000000000003000000000000000000000000000000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000001076163636f756e740972656769657374657204ff01200000000606ff010c0000000504061000a89c134602000000000000000000002000a89c1346020000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001010011100c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0264000087930300000000a086010000000000006889090000000000");
    final decodeRawTx = AptosRawTransaction.deserialize(rawTx.toBcs());
    expect(decodeRawTx.toBcs(), rawTx.toBcs());
  });
}

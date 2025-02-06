import 'package:blockchain_utils/signer/const/constants.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _entryFunction();
  _simpleTransaction();
  _signedTx();
  _challenge();
}

void _entryFunction() {
  test("MultiAgent transaction serialization", () {
    final function = AptosTransactionEntryFunction(
        moduleId: AptosModuleId(address: AptosAddress.one, name: "account"),
        functionName: "regiester",
        typeArgs: [AptosTypeTagSigner(), AptosTypeTagAddress()],
        args: [AptosAddress.one, MoveBool(false)]);

    final decode = AptosTransactionEntryFunction.deserialize(function.toBcs());
    expect(decode.toBcs(), function.toBcs());
    expect(decode.functionName, function.functionName);
    expect(decode.moduleId, function.moduleId);
    expect(decode.typeArgs, function.typeArgs);
    final payload =
        AptosTransactionPayloadEntryFunction(entryFunction: function);
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
    final decodeRawTx = AptosRawTransaction.deserialize(rawTx.toBcs());
    expect(decodeRawTx.toBcs(), rawTx.toBcs());
    expect(decodeRawTx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000010100000000000000020000000000000000000000000000000000000000000000000000000000000001076163636f756e74097265676965737465720205040220000000000000000000000000000000000000000000000000000000000000000101000087930300000000a086010000000000006889090000000001");

    AptosMultiAgentTransaction tx = AptosMultiAgentTransaction(
        rawTransaction: decodeRawTx,
        secondarySignerAddresses: [
          AptosAddress.one,
          AptosAddress.two,
          AptosAddress.three
        ]);
    expect(tx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000010100000000000000020000000000000000000000000000000000000000000000000000000000000001076163636f756e74097265676965737465720205040220000000000000000000000000000000000000000000000000000000000000000101000087930300000000a0860100000000000068890900000000010300000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300");
    AptosMultiAgentTransaction decodeTx =
        AptosMultiAgentTransaction.deserialize(tx.toBcs());
    expect(tx.toBcs(), decodeTx.toBcs());
    expect(decodeTx.feePayerAddress, null);
    expect(decodeTx.secondarySignerAddresses, tx.secondarySignerAddresses);
    tx = AptosMultiAgentTransaction(
        rawTransaction: decodeRawTx,
        feePayerAddress: AptosAddress.two,
        secondarySignerAddresses: [AptosAddress.three]);
    expect(tx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000010100000000000000020000000000000000000000000000000000000000000000000000000000000001076163636f756e74097265676965737465720205040220000000000000000000000000000000000000000000000000000000000000000101000087930300000000a086010000000000006889090000000001010000000000000000000000000000000000000000000000000000000000000003010000000000000000000000000000000000000000000000000000000000000002");
    decodeTx = AptosMultiAgentTransaction.deserialize(tx.toBcs());
    expect(tx.toBcs(), decodeTx.toBcs());
    expect(decodeTx.feePayerAddress, tx.feePayerAddress);
    expect(decodeTx.secondarySignerAddresses, tx.secondarySignerAddresses);
  });
}

void _simpleTransaction() {
  test("Simple Transaction serialization", () {
    final script = AptosScript(byteCode: List<int>.filled(12, 32), typeArgs: [
      AptosTypeTagBoolean(),
      AptosTypeTagStruct(AptosStructTag(
          address: AptosAddress.one,
          moduleName: "account",
          name: "coin",
          typeArgs: [
            AptosTypeTagAddress(),
          ]))
    ], arguments: [
      MoveU8(12),
      MoveU64(BigInt.parse("2500000000000")),
    ]);
    final payload = AptosTransactionPayloadScript(script: script);
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
    final decodeRawTx = AptosRawTransaction.deserialize(rawTx.toBcs());
    expect(decodeRawTx.toBcs(), rawTx.toBcs());
    expect(rawTx, decodeRawTx);
    expect(rawTx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000020100000000000000000c2020202020202020202020200200070000000000000000000000000000000000000000000000000000000000000001076163636f756e7404636f696e010402000c0100a89c13460200000087930300000000a086010000000000006889090000000001");
  });
}

void _signedTx() {
  test("signed transaction", () {
    AptosTransactionAuthenticatorMultiAgent getAuth() {
      AptosAccountAuthenticatorSingleKey secondAuth() {
        final publicKey =
            AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12))
                .publicKey;
        return AptosAccountAuthenticatorSingleKey(
            publicKey: publicKey,
            signature: AptosSecp256k1AnySignature(
                List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0)));
      }

      final msigAccount = AptosMultiKeyAccountPublicKey(publicKeys: [
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12)).publicKey,
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13)).publicKey,
      ], requiredSignature: 2);
      final auth = AptosAccountAuthenticatorMultiKey(
          publicKey: msigAccount,
          signature: AptosMultiKeySignature(signatures: [
            AptosSecp256k1AnySignature(
                List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0)),
            AptosEd25519AnySignature(
                List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0)),
          ], bitmap: [
            3,
            0,
            0,
            0
          ]));
      return AptosTransactionAuthenticatorMultiAgent(
          sender: auth,
          secondarySignerAddressess: [AptosAddress.one],
          secondarySigner: [auth, secondAuth()]);
    }

    final function = AptosTransactionEntryFunction(
        moduleId: AptosModuleId(address: AptosAddress.one, name: "account"),
        functionName: "regiester",
        typeArgs: [AptosTypeTagSigner(), AptosTypeTagAddress()],
        args: [AptosAddress.one, MoveBool(false)]);

    final decode = AptosTransactionEntryFunction.deserialize(function.toBcs());
    expect(decode.toBcs(), function.toBcs());
    expect(decode.functionName, function.functionName);
    expect(decode.moduleId, function.moduleId);
    expect(decode.typeArgs, function.typeArgs);
    final payload =
        AptosTransactionPayloadEntryFunction(entryFunction: function);
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
    final signedTx =
        AptosSignedTransaction(rawTransaction: rawTx, authenticator: getAuth());
    expect(signedTx.toBcsHex(),
        "00000000000000000000000000000000000000000000000000000000000000010100000000000000020000000000000000000000000000000000000000000000000000000000000001076163636f756e74097265676965737465720205040220000000000000000000000000000000000000000000000000000000000000000101000087930300000000a0860100000000000068890900000000010203020141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9002091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a020201400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004030000000100000000000000000000000000000000000000000000000000000000000000010203020141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9002091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a02020140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000403000000020141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decodeSignedTx = AptosSignedTransaction.deserialize(signedTx.toBcs());
    expect(decodeSignedTx.toBcs(), signedTx.toBcs());
  });
}

void _challenge() {
  test("rootate proof challenge", () {
    final challenge = RotationProofChallenge(
        orginator: AptosAddress.one,
        currentAuthKey: AptosAddress.two,
        newPublicKey:
            AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12))
                .publicKey,
        sequenceNumber: BigInt.one);
    expect(challenge.toBcsHex(),
        "0000000000000000000000000000000000000000000000000000000000000001076163636f756e7416526f746174696f6e50726f6f664368616c6c656e6765010000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002430141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9");
  });
}

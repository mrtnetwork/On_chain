import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';
import 'package:on_chain/near/src/nep/prefix.dart';
import 'package:on_chain/near/src/transaction/transaction.dart';
import 'package:test/test.dart';

import 'test_vector.dart';

import '../../utils.dart';

void serializationSerializationTest() {
  group('NEAR/Serialization', () {
    transaction();
    delegateAction();
    transferAction();
    delegateActionPrefix();
    useGlobalContract();
    deployGlobalContract();
    globalContractIdentifier();
    deleteAccount();
    deleteKey();
    addKey();
    accessKeyPermission();
    stake();
    transfer();
    functionCall();
    deployContract();
    accessKey();
    functionCallPermission();
    _testSignature();
  });
}

void main() {
  OnChainUtilsTestApi.runTest(serializationSerializationTest, "Serialization");
}

// factory NearFunctionCallPermission.deserialize(List<int> bytes) {
//   final decode = LayoutSerializable.deserialize(
//     bytes: bytes,
//     layout: NearFunctionCallPermission.layout(),
//   );
//   return NearFunctionCallPermission.deserializeJson(decode);
// }
void transaction() {
  test("transaction", () {
    final transaction = NearTransaction.deserialize(
      BytesUtils.fromHexString(testVector["transaction"]["encode"]),
    );
    _expectHex(
      transaction.toSerializeBytes(),
      testVector["transaction"]["encode"],
    );
    expect(transaction.signerId, "alice.near");
    expect(transaction.receiverId, "bob.near");
    expect(
      transaction.blockHash,
      testVector["transaction"]["data"]["blockHash"],
    );
    expect(transaction.actions.length, 2);
    expect(transaction.actions.elementAt(1), TypeMatcher<ActionFunctionCall>());
    expect(
      (transaction.actions.elementAt(1) as ActionFunctionCall)
          .functionCall
          .methodName,
      "set_greeting",
    );
  });
  test("transaction", () {
    final transaction = NearTransaction.deserialize(
      BytesUtils.fromHexString(
        testVector["transactionWithAllActions"]["encode"],
      ),
    );
    _expectHex(
      transaction.toSerializeBytes(),
      testVector["transactionWithAllActions"]["encode"],
    );
    expect(transaction.signerId, "alice.near");
    expect(transaction.receiverId, "bob.near");
  });
}

void delegateAction() {
  test("delegateAction", () {
    final delegateAction = NearDelegateAction.deserialize(
      BytesUtils.fromHexString(testVector["delegateAction"]["encode"]),
    );
    _expectHex(
      delegateAction.toSerializeBytes(),
      testVector["delegateAction"]["encode"],
    );
    expect(delegateAction.maxBlockHeight, BigInt.parse("123456789"));
    expect(delegateAction.nonce, BigInt.from(7));
    expect(delegateAction.actions.length, 2);
    expect(
      delegateAction.actions.elementAt(0),
      TypeMatcher<ActionCreateAccount>(),
    );

    expect(delegateAction.actions.elementAt(1), TypeMatcher<ActionTransfer>());
    expect(
      (delegateAction.actions.elementAt(1) as ActionTransfer).transfer.deposit,
      BigInt.parse("1000000000000000000000000"),
    );
  });
}

void transferAction() {
  test("transferAction", () {
    final classicActions = NearClassicAction.deserialize(
      BytesUtils.fromHexString(testVector["classicActions"]["encode"]),
    );
    _expectHex(
      classicActions.toSerializeVariantBytes(),
      testVector["classicActions"]["encode"],
    );
    expect(classicActions, TypeMatcher<ActionTransfer>());
    expect(
      (classicActions as ActionTransfer).transfer.deposit,
      BigInt.parse("1000000000000000000000000"),
    );
  });
}

void delegateActionPrefix() {
  test("delegateActionPrefix", () {
    final delegateActionPrefix = DelegateActionPrefix.deserialize(
      BytesUtils.fromHexString(testVector["delegateActionPrefix"]["encode"]),
    );
    _expectHex(
      delegateActionPrefix.toSerializeBytes(),
      testVector["delegateActionPrefix"]["encode"],
    );
    expect(delegateActionPrefix.prefix, 439041101);
  });
}

void useGlobalContract() {
  test("useGlobalContract", () {
    final useGlobalContract = NearUseGlobalContract.deserialize(
      BytesUtils.fromHexString(testVector["useGlobalContract"]["encode"]),
    );
    _expectHex(
      useGlobalContract.toSerializeBytes(),
      testVector["useGlobalContract"]["encode"],
    );
    expect(
      useGlobalContract.contractIdentifier,
      TypeMatcher<NearGlobalContractIdentifierAccountId>(),
    );
    expect(
      (useGlobalContract.contractIdentifier
              as NearGlobalContractIdentifierAccountId)
          .accountId,
      "global.contract.near",
    );
  });
}

void deployGlobalContract() {
  test("deployGlobalContract", () {
    final deployGlobalContract = NearDeployGlobalContract.deserialize(
      BytesUtils.fromHexString(testVector["deployGlobalContract"]["encode"]),
    );
    _expectHex(
      deployGlobalContract.toSerializeBytes(),
      testVector["deployGlobalContract"]["encode"],
    );
    expect(deployGlobalContract.code, [0, 0, 0, 0, 0, 0, 0, 0]);
    expect(
      deployGlobalContract.deployMode.type,
      NearGlobalContractDeployModeType.codeHash,
    );
  });
}

void globalContractIdentifier() {
  test("globalContractIdentifier", () {
    final globalContractIdentifier = NearGlobalContractIdentifier.deserialize(
      BytesUtils.fromHexString(
        testVector["globalContractIdentifier"]["encode"],
      ),
    );
    _expectHex(
      globalContractIdentifier.toSerializeVariantBytes(),
      testVector["globalContractIdentifier"]["encode"],
    );
    expect(
      globalContractIdentifier,
      TypeMatcher<NearGlobalContractIdentifierAccountId>(),
    );
    expect(
      (globalContractIdentifier as NearGlobalContractIdentifierAccountId)
          .accountId,
      "global.contract.near",
    );
  });
}

void deleteAccount() {
  test("deleteAccount", () {
    final deleteAccount = NearDeleteAccount.deserialize(
      BytesUtils.fromHexString(testVector["deleteAccount"]["encode"]),
    );
    _expectHex(
      deleteAccount.toSerializeBytes(),
      testVector["deleteAccount"]["encode"],
    );
    expect(deleteAccount.beneficiaryId, "beneficiary.near");
  });
}

void deleteKey() {
  test("deleteKey", () {
    final addKey = NearDeleteKey.deserialize(
      BytesUtils.fromHexString(testVector["deleteKey"]["encode"]),
    );
    _expectHex(addKey.toSerializeBytes(), testVector["deleteKey"]["encode"]);
    expect(addKey.publicKey, TypeMatcher<NearEd25519PublicKey>());
  });
}

void addKey() {
  test("addKey", () {
    final addKey = NearAddKey.deserialize(
      BytesUtils.fromHexString(testVector["addKey"]["encode"]),
    );
    _expectHex(addKey.toSerializeBytes(), testVector["addKey"]["encode"]);
    expect(addKey.publicKey, TypeMatcher<NearEd25519PublicKey>());
    expect(addKey.accessKey.nonce, BigInt.from(42));
  });
}

void accessKeyPermission() {
  test("accessKeyPermission", () {
    final accessKeyPermission = NearAccessKeyPermission.deserialize(
      BytesUtils.fromHexString(testVector["accessKeyPermission"]["encode"]),
    );
    _expectHex(
      accessKeyPermission.toSerializeVariantBytes(),
      testVector["accessKeyPermission"]["encode"],
    );
    expect(accessKeyPermission.type, NearAccessKeyPermissionType.fullAccess);
  });
}

void stake() {
  test("stake", () {
    final stake = NearStake.deserialize(
      BytesUtils.fromHexString(testVector["stake"]["encode"]),
    );
    _expectHex(stake.toSerializeBytes(), testVector["stake"]["encode"]);
    expect(stake.stake, BigInt.parse("50000000000000000000000000"));
    expect(stake.publicKey, TypeMatcher<NearEd25519PublicKey>());
  });
}

void transfer() {
  test("transfer", () {
    final transfer = NearTransfer.deserialize(
      BytesUtils.fromHexString(testVector["transfer"]["encode"]),
    );
    _expectHex(transfer.toSerializeBytes(), testVector["transfer"]["encode"]);
    expect(transfer.deposit, BigInt.parse("1000000000000000000000000"));
  });
}

void functionCall() {
  test("functionCall", () {
    final functionCallPermission = NearFunctionCall.deserialize(
      BytesUtils.fromHexString(testVector["functionCall"]["encode"]),
    );
    _expectHex(
      functionCallPermission.toSerializeBytes(),
      testVector["functionCall"]["encode"],
    );
    expect(functionCallPermission.gas, BigInt.parse("30000000000000"));
    expect(functionCallPermission.methodName, "set_greeting");
    expect(functionCallPermission.deposit, BigInt.zero);
  });
}

void deployContract() {
  test("deployContract", () {
    final functionCallPermission = NearDeployContract.deserialize(
      BytesUtils.fromHexString(testVector["deployContract"]["encode"]),
    );
    _expectHex(
      functionCallPermission.toSerializeBytes(),
      testVector["deployContract"]["encode"],
    );
    expect(functionCallPermission.code, [0, 0, 0, 0, 0, 0, 0, 0]);
  });
}

void accessKey() {
  test("accessKey", () {
    final functionCallPermission = NearAccessKey.deserialize(
      BytesUtils.fromHexString(testVector["accessKey"]["encode"]),
    );
    _expectHex(
      functionCallPermission.toSerializeBytes(),
      testVector["accessKey"]["encode"],
    );
    expect(functionCallPermission.nonce, BigInt.from(42));
    expect(
      functionCallPermission.permission,
      TypeMatcher<NearAccessKeyPermissionFullAccess>(),
    );
  });
}

void functionCallPermission() {
  test("functionCallPermission", () {
    final functionCallPermission = NearFunctionCallPermission.deserialize(
      BytesUtils.fromHexString(testVector["functionCallPermission"]["encode"]),
    );
    _expectHex(
      functionCallPermission.toSerializeBytes(),
      testVector["functionCallPermission"]["encode"],
    );
    expect(
      functionCallPermission.allowance,
      BigInt.parse("1000000000000000000000000"),
    );
    expect(functionCallPermission.methodNames, [
      "ft_transfer",
      "storage_deposit",
    ]);
  });
}

void _testSignature() {
  test("signature", () {
    final signature = NearSignature.deserialize(
      BytesUtils.fromHexString(testVector["signature"]["encode"]),
    );
    _expectHex(
      signature.toSerializeVariantBytes(),
      testVector["signature"]["encode"],
    );
    expect(signature, TypeMatcher<NearSignatureED25519>());
  });
  test("ed25519Signature", () {
    final signature = NearSignatureED25519(
      testVector["ed25519Signature"]["data"]["data"],
    );
    _expectHex(
      signature.toSerializeBytes(),
      testVector["ed25519Signature"]["encode"],
    );
  });
  test("secp256k1Signature", () {
    final signature = NearSignatureSECP256K1(
      testVector["secp256k1Signature"]["data"]["data"],
    );
    _expectHex(
      signature.toSerializeBytes(),
      testVector["secp256k1Signature"]["encode"],
    );
  });
  test("mlDsa65Signature", () {
    final signature = NearSignatureMLDSA65(
      testVector["mlDsa65Signature"]["data"]["data"],
    );
    _expectHex(
      signature.toSerializeBytes(),
      testVector["mlDsa65Signature"]["encode"],
    );
  });
}

void _expectHex(List<int> data, String hex) {
  expect(data, BytesUtils.fromHexString(hex));
}

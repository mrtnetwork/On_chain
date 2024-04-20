import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/constant.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

import '../../models/transaction/witnesses/witnesses.dart';

class ADATransactionBuilderUtils {
  static BootstrapWitness fakeBootStrapWitness(String byronAddr) {
    final address = ADAByronAddress(byronAddr);
    return BootstrapWitness(
        vkey: Vkey(
            List<int>.filled(AdaTransactionConstant.blake2b256DigestSize, 0)),
        signature: Ed25519Signature(
            List<int>.filled(AdaTransactionConstant.signatureLength, 0)),
        chainCode:
            List<int>.filled(AdaTransactionConstant.blake2b256DigestSize, 0),
        attributes: address.attributeSerialize());
  }

  static Vkeywitness fakeVkeyWitnessWitness() {
    return Vkeywitness(
        vKey: Vkey(
            List<int>.filled(AdaTransactionConstant.blake2b256DigestSize, 0)),
        signature: Ed25519Signature(
            List<int>.filled(AdaTransactionConstant.signatureLength, 0)));
  }
}

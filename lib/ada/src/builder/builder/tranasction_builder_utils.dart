import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/constant.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

import '../../models/transaction/witnesses/witnesses.dart';

class ADATransactionBuilderUtils {
  static final List<int> _fake32Bytes = List<int>.unmodifiable(
      List<int>.filled(AdaTransactionConstant.blake2b256DigestSize, 0));
  static final List<int> _fakeSignature = List<int>.unmodifiable(
      List<int>.filled(AdaTransactionConstant.signatureLength, 0));
  static BootstrapWitness fakeBootStrapWitness(String byronAddr) {
    final address = ADAByronAddress(byronAddr);
    return BootstrapWitness(
        vkey: Vkey(_fake32Bytes),
        signature: Ed25519Signature(_fakeSignature),
        chainCode: _fake32Bytes,
        attributes: address.attributeSerialize());
  }

  static Vkeywitness fakeVkeyWitnessWitness() {
    return Vkeywitness(
        vKey: Vkey(_fake32Bytes), signature: Ed25519Signature(_fakeSignature));
  }
}

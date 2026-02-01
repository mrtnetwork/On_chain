import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/bootstrap_witness.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/vkey_witness.dart';

class ADATransactionBuilderUtils {
  static List<int> get fakeBodyHash =>
      List<int>.unmodifiable(List.filled(QuickCrypto.blake2b256DigestSize, 12));
  static BootstrapWitness fakeBootStrapWitness(ADAByronAddress byronAddr) {
    final fakeVk =
        List<int>.filled(AdaTransactionConstant.blake2b256DigestSize, 0)
            .immutable;
    return BootstrapWitness(
        vkey: Vkey(fakeVk),
        signature: Ed25519Signature(
            List<int>.filled(AdaTransactionConstant.signatureLength, 0)),
        chainCode: fakeVk,
        attributes: byronAddr.attributeSerialize());
  }

  static Vkeywitness fakeVkeyWitnessWitness() {
    return Vkeywitness(
        vKey: Vkey(
            List<int>.filled(AdaTransactionConstant.blake2b256DigestSize, 0)),
        signature: Ed25519Signature(
            List<int>.filled(AdaTransactionConstant.signatureLength, 0)));
  }
}

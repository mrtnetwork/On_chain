import 'package:blockchain_utils/crypto/quick_crypto.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/bootstrap_witness.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/vkey_witness.dart';

class ADATransactionBuilderUtils {
  static final List<int> fakeBodyHash =
      List<int>.unmodifiable(List.filled(QuickCrypto.blake2b256DigestSize, 12));
  static final List<int> _fake32Bytes = List<int>.unmodifiable(
      List<int>.filled(AdaTransactionConstant.blake2b256DigestSize, 0));
  static final List<int> _fakeSignature = List<int>.unmodifiable(
      List<int>.filled(AdaTransactionConstant.signatureLength, 0));
  static BootstrapWitness fakeBootStrapWitness(ADAByronAddress byronAddr) {
    return BootstrapWitness(
        vkey: Vkey(_fake32Bytes),
        signature: Ed25519Signature(_fakeSignature),
        chainCode: _fake32Bytes,
        attributes: byronAddr.attributeSerialize());
  }

  static Vkeywitness fakeVkeyWitnessWitness() {
    return Vkeywitness(
        vKey: Vkey(_fake32Bytes), signature: Ed25519Signature(_fakeSignature));
  }
}

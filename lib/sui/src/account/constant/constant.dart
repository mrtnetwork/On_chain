import 'package:blockchain_utils/utils/binary/binary_operation.dart';

class SuiAccountConst {
  static const int multisigAccountMaxThreshold = BinaryOps.mask16;
  static const int multisigAccountMinThreshold = 1;
  static const int multisigAccountMaxPublicKey = 10;
  static const int multisigAccountPublicKeyMaxWeight = 255;
  static const int multisigAccountPublicKeyMinWeight = 1;
}

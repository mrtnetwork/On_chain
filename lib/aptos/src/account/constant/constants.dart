import 'package:blockchain_utils/utils/binary/binary_operation.dart';

class AptosAccountConst {
  static const int multiKeyMaxKeys = mask32;
  static const int mulitKeyMinRequiredSignature = 1;
  static const int multiKeyMaxRequiredSignature = 32;

  /// Max number of keys in the multi-signature account
  static const int multiEd25519MaxKeys = 32;

  /// Minimum number of keys required
  static const int multiEd25519MinKeys = 2;

  /// Minimum threshold of required signatures
  static const int multiEd25519MinThreshold = 1;
}

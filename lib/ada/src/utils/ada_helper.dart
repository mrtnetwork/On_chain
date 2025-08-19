import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/asset_name.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

class ADAHelper {
  static const String adaUnit = 'lovelace';
  static final BigRational _adaDecimal = BigRational(BigInt.from(10).pow(6));

  static BigInt toLovelaces(String amount) {
    final parse = BigRational.parseDecimal(amount);
    return (parse * _adaDecimal).toBigInt();
  }

  static Tuple<PolicyID, AssetName> separatePolcyAndAssetName(String hex) {
    final toBytes = BytesUtils.fromHexString(hex);
    final PolicyID policyID = PolicyID(
        toBytes.sublist(0, AdaTransactionConstant.blake2b224DigestSize));
    final AssetName assetName =
        AssetName(toBytes.sublist(AdaTransactionConstant.blake2b224DigestSize));
    return Tuple(policyID, assetName);
  }
}

import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/transaction/transaction.dart';

class AptosConstants {
  static int maxSignatureLength = 32;
  static int bitmapLength = 4;
  static int decimal = 8;
  static const List<int> rawTransactionSalt = [
    181,
    233,
    125,
    176,
    127,
    160,
    189,
    14,
    85,
    152,
    170,
    54,
    67,
    169,
    188,
    111,
    102,
    147,
    189,
    220,
    26,
    159,
    236,
    158,
    103,
    74,
    70,
    30,
    170,
    0,
    177,
    147
  ];
  static const List<int> rawTransactionWithDataSalt = [
    94,
    250,
    60,
    79,
    2,
    248,
    58,
    15,
    75,
    45,
    105,
    252,
    149,
    198,
    7,
    204,
    2,
    130,
    92,
    196,
    231,
    190,
    83,
    110,
    240,
    153,
    45,
    240,
    80,
    217,
    230,
    124
  ];
  static const List<int> transactionHashDomain = [
    250,
    33,
    10,
    148,
    23,
    239,
    62,
    127,
    164,
    91,
    250,
    29,
    23,
    168,
    219,
    212,
    216,
    131,
    113,
    25,
    16,
    165,
    80,
    210,
    101,
    254,
    225,
    137,
    233,
    38,
    109,
    212
  ];
  static final AptosStructTag object = AptosStructTag(
      address: AptosAddress.one, moduleName: 'object', name: 'Object');
  static final AptosStructTag string = AptosStructTag(
      address: AptosAddress.one, moduleName: 'string', name: 'String');
  static final AptosStructTag option = AptosStructTag(
      address: AptosAddress.one, moduleName: 'option', name: 'Option');

  static final AptosModuleId systemFrameworkCoinModuleId =
      AptosModuleId(address: AptosAddress.one, name: "coin");
  static final AptosModuleId systemFrameworkAccountModuleId =
      AptosModuleId(address: AptosAddress.one, name: "aptos_account");
  static const String transferFunctionName = 'transfer';
  static const String batchTransferFunctionName = 'batch_transfer';
  static final AptosModuleId publishModuleModuleId =
      AptosModuleId(address: AptosAddress.one, name: "code");
  static const String publishModuleFunctionName = 'publish_package_txn';
  static final aptosCoinTypeStructArgs = AptosTypeTagStruct(AptosStructTag(
      address: AptosAddress.one, moduleName: "aptos_coin", name: "AptosCoin"));
  static final BigInt defaultMaxGasAmount = BigInt.from(200000);
  static final BigInt defaultMinGasAmount = BigInt.from(15000);
  static const String aptosCoinAssetType = "0x1::aptos_coin::AptosCoin";
  static final AptosTypeTagStruct fungibleAssetMetadataTypeTag =
      AptosTypeTagStruct(AptosStructTag(
          address: AptosAddress.one,
          moduleName: "fungible_asset",
          name: "Metadata"));
  static final primaryFungibleStoreModule =
      AptosModuleId(address: AptosAddress.one, name: "primary_fungible_store");
}

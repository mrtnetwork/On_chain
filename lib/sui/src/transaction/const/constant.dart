class SuiTransactionConst {
  static const int digestLength = 32;
  static const String suiTypeArgs = "0x2::sui::SUI";
  static const String transactionDataDomain = "TransactionData::";
  static BigInt get maxGas => BigInt.from(5e10);
  static BigInt get gasSafeOverHead => BigInt.from(1000);
  static BigInt get minGas => BigInt.from(1000000);
}

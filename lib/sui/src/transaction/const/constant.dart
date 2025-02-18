class SuiTransactionConst {
  static const int digestLength = 32;
  static const String suiTypeArgs = "0x2::sui::SUI";
  static final BigInt maxGas = BigInt.from(5e10);

  static final BigInt gasSafeOverHead = BigInt.from(1000);
  static final BigInt minGas = BigInt.from(1000000);
  static final String transactionDataDomain = "TransactionData::";
}

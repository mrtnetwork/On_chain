/// Parameters required to build an Aptos transaction.
class AptosApiBuildTransactionParams {
  /// The ID of the blockchain network (optional).
  final int? chainId;

  /// The expiration time of the transaction in seconds since epoch (optional).
  final BigInt? transactionExpireTime;

  /// The maximum amount of gas allowed for the transaction.
  final BigInt? maxGasAmount;

  /// The price per unit of gas (optional).
  final BigInt? gasUnitPrice;

  /// Set sequenceNumber to zero if the account is inactive
  /// and you want to create a feePayer transaction.
  final BigInt? sequenceNumber;
  const AptosApiBuildTransactionParams(
      {this.chainId,
      this.transactionExpireTime,
      this.maxGasAmount,
      this.gasUnitPrice,
      this.sequenceNumber});
}

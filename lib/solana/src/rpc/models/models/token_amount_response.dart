class TokenAmoutResponse {
  const TokenAmoutResponse({
    required this.amount,
    required this.decimals,
    this.uiAmount,
    this.uiAmountString,
  });
  factory TokenAmoutResponse.fromJson(Map<String, dynamic> json) {
    final uiAmount = json['uiAmount'];
    return TokenAmoutResponse(
      amount: json['amount'],
      decimals: json['decimals'],
      uiAmount: uiAmount == null ? null : (uiAmount as num).toDouble(),
      uiAmountString: json['uiAmountString'],
    );
  }

  /// Raw amount of tokens as string ignoring decimals
  final String amount;

  /// Number of decimals configured for token's mint
  final int decimals;

  /// Token amount as float, accounts for decimals
  final double? uiAmount;

  /// Token amount as string, accounts for decimals
  final String? uiAmountString;
}

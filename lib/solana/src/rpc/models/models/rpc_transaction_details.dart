class RPCTransactionDetails {
  const RPCTransactionDetails._(this.value);
  final String value;
  static const RPCTransactionDetails full = RPCTransactionDetails._('full');
  static const RPCTransactionDetails accounts =
      RPCTransactionDetails._('accounts');
  static const RPCTransactionDetails signatures =
      RPCTransactionDetails._('signatures');
  static const RPCTransactionDetails none = RPCTransactionDetails._('none');

  Map<String, dynamic> toJson() {
    return {'transactionDetails': value};
  }

  @override
  String toString() {
    return 'RPCTransactionDetails.$value';
  }
}

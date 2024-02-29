/// evel of transaction detail to return
class BlockSubscribeTransactionDetails {
  final String name;
  const BlockSubscribeTransactionDetails._(this.name);
  static const BlockSubscribeTransactionDetails full =
      BlockSubscribeTransactionDetails._("full");
  static const BlockSubscribeTransactionDetails accounts =
      BlockSubscribeTransactionDetails._("accounts");
  static const BlockSubscribeTransactionDetails signatures =
      BlockSubscribeTransactionDetails._("signatures");
  static const BlockSubscribeTransactionDetails none =
      BlockSubscribeTransactionDetails._("none");

  Map<String, dynamic> toJson() {
    return {"transactionDetails": name};
  }

  @override
  String toString() {
    return "BlockSubscribeTransactionDetails.$name";
  }
}

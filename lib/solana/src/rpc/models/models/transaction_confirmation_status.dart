import 'package:on_chain/solana/src/exception/exception.dart';

class TransactionConfirmationStatus {
  final String name;
  final int value;
  const TransactionConfirmationStatus._(this.name, this.value);
  static const TransactionConfirmationStatus processed =
      TransactionConfirmationStatus._("Processed", 0);
  static const TransactionConfirmationStatus confirmed =
      TransactionConfirmationStatus._("Confirmed", 1);
  static const TransactionConfirmationStatus finalized =
      TransactionConfirmationStatus._("Finalized", 2);
  static const List<TransactionConfirmationStatus> values = [
    processed,
    confirmed,
    finalized
  ];

  factory TransactionConfirmationStatus.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name.toLowerCase() == value?.toLowerCase(),
      orElse: () => throw SolanaPluginException(
          "No TransactionConfirmationStatus found matching the specified value",
          details: {"value": value}),
    );
  }
  factory TransactionConfirmationStatus.fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No TransactionConfirmationStatus found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "TransactionConfirmationStatus.$name";
  }
}

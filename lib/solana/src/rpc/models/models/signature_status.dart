import 'transaction_confirmation_status.dart';

/// Signature status
class SignatureStatus {
  /// when the transaction was processed
  final int slot;

  /// the number of blocks that have been confirmed and voted on in the fork containing `slot`
  final int? confirmations;

  /// transaction error, if any
  final dynamic err;

  /// cluster confirmation status, if data available. Possible responses:
  /// [TransactionConfirmationStatus.confirmed], [TransactionConfirmationStatus.finalized], [TransactionConfirmationStatus.processed]
  final TransactionConfirmationStatus? confirmationStatus;
  const SignatureStatus(
      {required this.slot,
      required this.confirmations,
      required this.err,
      required this.confirmationStatus});
  factory SignatureStatus.fromJson(Map<String, dynamic> json) {
    return SignatureStatus(
        slot: json['slot'],
        confirmations: json['confirmations'],
        err: json['err'],
        confirmationStatus: json['confirmationStatus'] == null
            ? null
            : TransactionConfirmationStatus.fromName(
                json['confirmationStatus']));
  }
}

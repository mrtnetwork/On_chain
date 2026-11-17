import 'transaction_confirmation_status.dart';

/// Signature information for a confirmed transaction
/// (getSignaturesForAddress item).
class ConfirmedSignatureInfo {
  const ConfirmedSignatureInfo({
    required this.signature,
    required this.slot,
    required this.err,
    this.memo,
    this.blockTime,
    this.confirmationStatus,
    this.transactionIndex,
  });
  factory ConfirmedSignatureInfo.fromJson(Map<String, dynamic> json) {
    return ConfirmedSignatureInfo(
      signature: json['signature'],
      slot: json['slot'],
      err: json['err'],
      memo: json['memo'],
      blockTime: json['blockTime'],
      confirmationStatus:
          json['confirmationStatus'] == null
              ? null
              : TransactionConfirmationStatus.fromName(
                json['confirmationStatus'],
              ),
      transactionIndex: json['transactionIndex'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'signature': signature,
      'slot': slot,
      'err': err,
      'memo': memo,
      'blockTime': blockTime,
      'confirmationStatus': confirmationStatus?.name.toLowerCase(),
      'transactionIndex': transactionIndex,
    };
  }

  /// Transaction signature.
  final String signature;

  /// The slot that contains the block with the transaction.
  final int slot;

  /// Transaction error, if any.
  final dynamic err;

  /// Memo associated with the transaction, if any.
  final String? memo;

  /// Estimated production time of the block (Unix timestamp).
  final int? blockTime;

  /// Cluster confirmation status, if data available.
  final TransactionConfirmationStatus? confirmationStatus;
  final int? transactionIndex;
}

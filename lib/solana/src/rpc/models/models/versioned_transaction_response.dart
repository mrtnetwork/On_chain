import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/transaction/transaction.dart';
import 'confirmed_transaction_meta.dart';

class VersionedTransactionResponse {
  final int? slot;
  final SolanaTransaction? transaction;
  final ConfirmedTransactionMeta? meta;
  final BigInt? blockTime;
  final TransactionType? version;
  const VersionedTransactionResponse(
      {required this.blockTime,
      required this.meta,
      required this.slot,
      required this.transaction,
      required this.version});
  factory VersionedTransactionResponse.fromJson(Map<String, dynamic> json) {
    final version =
        json['version'] == null ? null : TransactionType.find(json['version']);
    final meta = json['meta'] == null
        ? null
        : ConfirmedTransactionMeta.fromJson(json['meta']);
    SolanaTransaction transaction;
    if (json['transaction'] is Map) {
      transaction =
          SolanaTransaction.fromJson(json['transaction'], version: version);
    } else {
      transaction = SolanaTransaction.deserialize(
          SolanaRequestEncoding.decode(json['transaction']),
          verifySignatures: version != null);
    }
    return VersionedTransactionResponse(
        blockTime: BigintUtils.tryParse(json['blockTime']),
        meta: meta,
        slot: json['slot'],
        transaction: transaction,
        version: version);
  }
}

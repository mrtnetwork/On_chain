import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';

/// Transaction Instruction
class TransactionInstruction {
  TransactionInstruction(
      {required List<AccountMeta> keys,
      required this.programId,
      required this.data})
      : keys = List<AccountMeta>.unmodifiable(keys);

  /// Public keys to include in this transaction
  /// Boolean represents whether this pubkey needs to sign the transaction
  final List<AccountMeta> keys;

  /// Program Id to execute.
  final SolAddress programId;

  /// Program input.
  List<int> data;

  @override
  String toString() {
    return "TransactionInstruction{keys: $keys, programID: $programId data: ${BytesUtils.toHexString(data)}}";
  }
}

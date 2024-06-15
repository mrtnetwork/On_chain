import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/models/lockup/accout_lookup_key.dart';

import 'compiled_inner_instruction.dart';
import 'token_balance.dart';

class ConfirmedTransactionMeta {
  /// The fee charged for processing the transaction
  final int fee;

  /// An array of cross program invoked parsed instructions
  final List<CompiledInnerInstruction>? innerInstructions;

  /// The balances of the transaction accounts before processing
  final List<BigInt> preBalances;

  /// The balances of the transaction accounts after processing
  final List<BigInt> postBalances;

  /// An array of program log messages emitted during a transaction
  final List<String>? logMessages;

  /// The token balances of the transaction accounts before processing
  final List<TokenBalance>? preTokenBalances;

  /// The token balances of the transaction accounts after processing
  final List<TokenBalance>? postTokenBalances;

  /// The error result of transaction processing
  final dynamic err;

  /// The collection of addresses loaded using address lookup tables
  final AccountLookupKeys? loadedAddresses;

  /// The compute units consumed after processing the transaction
  final int? computeUnitsConsumed;
  const ConfirmedTransactionMeta(
      {required this.fee,
      required this.innerInstructions,
      required this.preBalances,
      required this.postBalances,
      required this.logMessages,
      required this.preTokenBalances,
      required this.postTokenBalances,
      required this.err,
      required this.loadedAddresses,
      required this.computeUnitsConsumed});
  factory ConfirmedTransactionMeta.fromJson(Map<String, dynamic> json) {
    return ConfirmedTransactionMeta(
        fee: json["fee"],
        innerInstructions: (json["innerInstructions"] as List?)
            ?.map((e) => CompiledInnerInstruction.fromJson(e))
            .toList(),
        preBalances: (json["preBalances"] as List)
            .map((e) => BigintUtils.parse(e))
            .toList(),
        postBalances: (json["postBalances"] as List)
            .map((e) => BigintUtils.parse(e))
            .toList(),
        logMessages: (json["logMessages"] as List?)?.cast(),
        preTokenBalances: (json["preTokenBalances"] as List?)
            ?.map((e) => TokenBalance.fromJson(e))
            .toList(),
        postTokenBalances: (json["postTokenBalances"] as List?)
            ?.map((e) => TokenBalance.fromJson(e))
            .toList(),
        err: json["err"],
        loadedAddresses: json["loadedAddresses"] == null
            ? null
            : AccountLookupKeys.fromJson(json["loadedAddresses"]),
        computeUnitsConsumed: json["computeUnitsConsumed"]);
  }
}

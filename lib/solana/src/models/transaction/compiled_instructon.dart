import 'package:blockchain_utils/base58/base58.dart';
import 'package:on_chain/solana/src/rpc/models/models/encoding.dart';

/// Class representing a compiled instruction.
class CompiledInstruction {
  /// Constructor to create a CompiledInstruction instance.
  CompiledInstruction(
      {required this.programIdIndex,
      required List<int> accounts,
      required List<int>
          data}) // Ensure data and accounts lists are unmodifiable.
      : data = List<int>.unmodifiable(data),
        accounts = List<int>.unmodifiable(accounts);

  factory CompiledInstruction.fromJson(Map<String, dynamic> json) {
    return CompiledInstruction(
        programIdIndex: json["programIdIndex"],
        accounts: (json["accounts"] as List).cast(),
        data: SolanaRPCEncoding.decode(json["data"]));
  }

  /// Index into the transaction keys array indicating the program account that executes this instruction.
  final int programIdIndex;

  /// Ordered indices into the transaction keys array indicating which accounts to pass to the program.
  final List<int> accounts;

  /// The program input data.
  final List<int> data;

  Map<String, dynamic> toJson() {
    return {
      "programIdIndex": programIdIndex,
      "accounts": accounts,
      "data": Base58Encoder.encode(data)
    };
  }

  /// Override the toString method to provide a string representation of the object.
  @override
  String toString() {
    return "CompiledInstruction${toJson()}";
  }
}

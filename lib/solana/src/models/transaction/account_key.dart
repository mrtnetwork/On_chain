// Import necessary modules for blockchain utilities, Solana address management, and transaction models.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/models/lockup/accout_lookup_key.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';

import 'compiled_instructon.dart';

/// Class representing the keys associated with a Solana message.
class MessageAccountKeys {
  /// List of Solana addresses representing the accounts.
  final List<SolAddress> _accounts;

  /// Account lookup keys obtained from table lookups.
  final AccountLookupKeys? accountKeysFromLookups;

  /// Constructor to create a MessageAccountKeys instance.
  MessageAccountKeys(List<SolAddress> accounts, this.accountKeysFromLookups)
      : _accounts = List.unmodifiable(accounts);

  /// Segments of keys, including the accounts and lookup keys.
  late final List<List<SolAddress>> _keySegments = List.unmodifiable([
    _accounts,
    if (accountKeysFromLookups != null) ...[
      accountKeysFromLookups!.writable,
      accountKeysFromLookups!.readonly
    ]
  ]);

  /// Total length of all key segments combined.
  late final int length = _keySegments.expand((segment) => segment).length;

  /// Retrieve the Solana address at the specified index.
  SolAddress? byIndex(index) {
    for (final keySegment in _keySegments) {
      if (index < keySegment.length) {
        return keySegment[index];
      } else {
        index -= keySegment.length;
      }
    }
    return null;
  }

  /// Compile transaction instructions into compiled instructions.
  List<CompiledInstruction> compileInstructions(
      List<TransactionInstruction> instructions) {
    if (length > SolanaTransactionConstant.maximumAccountKeys) {
      throw const MessageException(
          'Account index overflow encountered during compilation');
    }
    Map<String, int> keyIndexMap = {};
    for (final keySegment in _keySegments.expand((segment) => segment)) {
      keyIndexMap[keySegment.address] = keyIndexMap.length;
    }
    int findKeyIndex(String key) {
      final keyIndex = keyIndexMap[key];
      if (keyIndex == null) {
        throw const MessageException(
            'Encountered an unknown instruction account key during compilation');
      }
      return keyIndex;
    }

    {
      return instructions.map((instruction) {
        return CompiledInstruction(
          programIdIndex: findKeyIndex(instruction.programId.address),
          accounts: instruction.keys
              .map((meta) => findKeyIndex(meta.publicKey.address))
              .toList(),
          data: instruction.data,
        );
      }).toList();
    }
  }
}

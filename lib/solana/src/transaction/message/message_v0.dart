import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/transaction/core/core.dart';
import 'package:on_chain/solana/src/transaction/utils/utils.dart';

/// A class representing a version 0 Solana message.
class MessageV0 implements VersionedMessage {
  /// The message header, identifying signed and read-only [accountKeys]
  @override
  final MessageHeader header;

  /// The account keys used by this transaction.
  @override
  final List<SolAddress> accountKeys;

  /// The hash of a recent ledger block.
  @override
  final SolAddress recentBlockhash;

  /// Instructions that will be executed in sequence and committed in one atomic transaction.
  @override
  final List<CompiledInstruction> compiledInstructions;

  /// The address table lookups associated with the message.
  final List<AddressTableLookup> addressTableLookups;

  /// Constructs a [MessageV0] with required parameters.
  const MessageV0({
    required this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.compiledInstructions,
    required this.addressTableLookups,
  });

  @override
  MessageV0 copyWith(
      {MessageHeader? header,
      List<SolAddress>? accountKeys,
      SolAddress? recentBlockhash,
      List<CompiledInstruction>? compiledInstructions,
      List<AddressTableLookup>? addressTableLookups}) {
    return MessageV0(
        header: header ?? this.header,
        accountKeys: accountKeys ?? this.accountKeys,
        recentBlockhash: recentBlockhash ?? this.recentBlockhash,
        compiledInstructions: compiledInstructions ?? this.compiledInstructions,
        addressTableLookups: addressTableLookups ?? this.addressTableLookups);
  }

  /// Compiles a version 0 message from provided parameters.
  factory MessageV0.compile({
    required List<TransactionInstruction> transactionInstructions,
    required SolAddress payer,
    required SolAddress recentBlockhash,
    List<AddressLookupTableAccount> lookupTableAccounts = const [],
  }) {
    return SolanaTransactionUtils.compileV0(
      transactionInstructions: transactionInstructions,
      payer: payer,
      recentBlockhash: recentBlockhash,
      lookupTableAccounts: lookupTableAccounts,
    );
  }

  /// Constructs a version 0 message from a serialized buffer.
  factory MessageV0.fromBuffer(List<int> serializedMessage) {
    return SolanaTransactionUtils.deserializeV0(serializedMessage);
  }

  /// Gets the version of the message.
  @override
  TransactionType get version => TransactionType.v0;

  /// Gets the number of account keys from lookups.
  int get numAccountKeysFromLookups {
    return addressTableLookups.fold<int>(0,
        (previousValue, element) => previousValue + element.numberOfAccounts);
  }

  /// Gets the accounts associated with the message.
  @override
  MessageAccountKeys getAccounts({
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
    AccountLookupKeys? lookupKeys,
  }) {
    if (lookupKeys != null) {
      if (numAccountKeysFromLookups !=
          lookupKeys.writable.length + lookupKeys.readonly.length) {
        throw const SolanaPluginException(
            'Failed to get account keys because of a mismatch in the number of account keys from lookups');
      }
    } else if (addressLookupTableAccounts.isNotEmpty) {
      lookupKeys = _resolveAddressTableLookups(addressLookupTableAccounts);
    } else if (addressTableLookups.isNotEmpty) {
      throw const SolanaPluginException(
          'Failed to get account keys because address table lookups were not resolved');
    }
    return MessageAccountKeys(accountKeys, lookupKeys);
  }

  /// Checks if an account at the specified index is a signer.
  @override
  bool isAccountSigner(int index) => header.isAccountSigner(index);

  /// Checks if an account at the specified index is writable.
  @override
  bool isAccountWritable(int index) => header.isAccountWritable(
      index: index,
      numStaticAccountKeys: accountKeys.length,
      addressTableLookups: addressTableLookups);

  /// Resolves address table lookups.
  AccountLookupKeys _resolveAddressTableLookups(
      List<AddressLookupTableAccount> addressLookupTableAccounts) {
    final List<SolAddress> writable = [];
    final List<SolAddress> readonly = [];
    for (var tableLookup in addressTableLookups) {
      final tableAccount = addressLookupTableAccounts.firstWhere(
        (account) => account.key == tableLookup.accountKey,
        orElse: () => throw SolanaPluginException(
            'Failed to find address lookup table account for table key ${tableLookup.accountKey}'),
      );
      for (var index in tableLookup.writableIndexes) {
        if (index < tableAccount.addresses.length) {
          writable.add(tableAccount.addresses[index]);
        } else {
          throw SolanaPluginException(
              'Failed to find address for index $index in address lookup table ${tableLookup.accountKey}');
        }
      }
      for (var index in tableLookup.readonlyIndexes) {
        if (index < tableAccount.addresses.length) {
          readonly.add(tableAccount.addresses[index]);
        } else {
          throw SolanaPluginException(
              'Failed to find address for index $index in address lookup table ${tableLookup.accountKey}');
        }
      }
    }
    return AccountLookupKeys(readonly: readonly, writable: writable);
  }

  /// Serializes the message.
  @override
  List<int> serialize() {
    return SolanaTransactionUtils.serializeV0(this);
  }
}

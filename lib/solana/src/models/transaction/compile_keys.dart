import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/accounts/accounts/account_lookup_table.dart';
import 'package:on_chain/solana/src/models/lockup/extract_table_lookup.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'package:on_chain/solana/src/models/lockup/table_lookup.dart';
import 'package:on_chain/solana/src/models/transaction/message_header.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';
import 'package:on_chain/solana/src/exception/exception.dart';

class CompiledKeys {
  final SolAddress payer;
  Map<String, _KeyMeta> _keyMetaMap;
  CompiledKeys._(
      {required this.payer, required Map<String, _KeyMeta> keyMetaMap})
      : _keyMetaMap = Map<String, _KeyMeta>.unmodifiable(keyMetaMap);

  factory CompiledKeys.compile(
      List<TransactionInstruction> instructions, SolAddress payer) {
    final keyMetaMap = <String, _KeyMeta>{};
    keyMetaMap[payer.address] ??= _KeyMeta.defaultKey();
    keyMetaMap[payer.address] =
        keyMetaMap[payer.address]!.copyWith(isSigner: true, isWritable: true);
    for (final ix in instructions) {
      final String programIdAddress = ix.programId.address;
      keyMetaMap[programIdAddress] ??= _KeyMeta.defaultKey();
      keyMetaMap[programIdAddress] =
          keyMetaMap[programIdAddress]!.copyWith(isInvoked: true);
      for (final accountMeta in ix.keys) {
        final addr = accountMeta.publicKey.address;
        keyMetaMap[addr] ??= _KeyMeta.defaultKey();
        final bool isSigner = keyMetaMap[addr]!.isSigner;
        final bool isWritable = keyMetaMap[addr]!.isWritable;
        if (!isSigner) {
          keyMetaMap[addr] =
              keyMetaMap[addr]!.copyWith(isSigner: accountMeta.isSigner);
        }
        if (!isWritable) {
          keyMetaMap[addr] =
              keyMetaMap[addr]!.copyWith(isWritable: accountMeta.isWritable);
        }
      }
    }
    return CompiledKeys._(payer: payer, keyMetaMap: keyMetaMap);
  }

  Tuple<MessageHeader, List<SolAddress>> getMessageComponents() {
    final mapEntries = _keyMetaMap.entries.toList();
    if (mapEntries.length > SolanaTransactionConstant.maximumAccountKeys) {
      throw const SolanaPluginException(
          'Max static account keys length exceeded');
    }
    final writableSigners = mapEntries
        .where((entry) => entry.value.isSigner && entry.value.isWritable)
        .toList();
    final readonlySigners = mapEntries
        .where((entry) => entry.value.isSigner && !entry.value.isWritable)
        .toList();
    final writableNonSigners = mapEntries
        .where((entry) => !entry.value.isSigner && entry.value.isWritable)
        .toList();
    final readonlyNonSigners = mapEntries
        .where((entry) => !entry.value.isSigner && !entry.value.isWritable)
        .toList();

    final MessageHeader header = MessageHeader(
        numRequiredSignatures: writableSigners.length + readonlySigners.length,
        numReadonlySignedAccounts: readonlySigners.length,
        numReadonlyUnsignedAccounts: readonlyNonSigners.length);
    if (writableSigners.isEmpty) {
      throw const SolanaPluginException(
          'Expected at least one writable signer key');
    }
    final payerAddress = writableSigners[0].key;
    if (payerAddress != payer.address) {
      throw const SolanaPluginException(
          'Expected first writable signer key to be the fee payer');
    }
    final List<SolAddress> staticAccountKeys = List<SolAddress>.unmodifiable([
      ...writableSigners.map((entry) => SolAddress(entry.key)),
      ...readonlySigners.map((entry) => SolAddress(entry.key)),
      ...writableNonSigners.map((entry) => SolAddress(entry.key)),
      ...readonlyNonSigners.map((entry) => SolAddress(entry.key)),
    ]);

    return Tuple(header, staticAccountKeys);
  }

  ExtractTableLookup? extractTableLookup(
      AddressLookupTableAccount lookupTable) {
    final writableIndexesAndKeys = _drainKeysFoundInLookupTable(
      lookupTable.addresses,
      (keyMeta) =>
          !keyMeta.isSigner && !keyMeta.isInvoked && keyMeta.isWritable,
    );
    final readonlyIndexesAndKeys = _drainKeysFoundInLookupTable(
      lookupTable.addresses,
      (keyMeta) =>
          !keyMeta.isSigner && !keyMeta.isInvoked && !keyMeta.isWritable,
    );
    if (writableIndexesAndKeys.item1.isEmpty &&
        readonlyIndexesAndKeys.item1.isEmpty) {
      return null;
    }
    return ExtractTableLookup(
        lookup: AddressTableLookup(
            accountKey: lookupTable.key,
            writableIndexes: writableIndexesAndKeys.item1,
            readonlyIndexes: readonlyIndexesAndKeys.item1),
        readable: readonlyIndexesAndKeys.item2,
        writable: writableIndexesAndKeys.item2);
  }

  Tuple<List<int>, List<SolAddress>> _drainKeysFoundInLookupTable(
      List<SolAddress> addresses, bool Function(_KeyMeta) predicate) {
    final indexes = <int>[];
    final drainedKeys = <SolAddress>[];
    for (final i in _keyMetaMap.entries) {
      if (predicate(i.value)) {
        final lookupTableIndex =
            addresses.indexWhere((element) => element.address == i.key);
        if (lookupTableIndex >= 0) {
          indexes.add(lookupTableIndex);
          drainedKeys.add(SolAddress(i.key));
          final keyMeta = Map.from(_keyMetaMap)
            ..removeWhere((key, value) => key == i.key);
          _keyMetaMap = Map.unmodifiable(keyMeta);
        }
      }
    }
    return Tuple(indexes, drainedKeys);
  }
}

class _KeyMeta {
  const _KeyMeta(
      {required this.isInvoked,
      required this.isSigner,
      required this.isWritable});
  final bool isSigner;
  final bool isWritable;
  final bool isInvoked;

  @override
  String toString() {
    return '_KeyMeta{isSigner: $isSigner, isWritable: $isWritable, isInvoked: $isInvoked}';
  }

  _KeyMeta copyWith({
    bool? isSigner,
    bool? isWritable,
    bool? isInvoked,
  }) {
    return _KeyMeta(
      isSigner: isSigner ?? this.isSigner,
      isWritable: isWritable ?? this.isWritable,
      isInvoked: isInvoked ?? this.isInvoked,
    );
  }

  factory _KeyMeta.defaultKey() {
    return const _KeyMeta(isInvoked: false, isSigner: false, isWritable: false);
  }
}

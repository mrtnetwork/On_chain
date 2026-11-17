import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/rpc/models/models/encoding.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';
import 'package:on_chain/solana/src/transaction/message/legacy.dart';
import 'package:on_chain/solana/src/transaction/message/message_v1.dart';
import 'package:on_chain/solana/src/transaction/message/message_v0.dart';
import 'package:on_chain/solana/src/transaction/message/transaction_v1_config.dart';

import '../../instructions/address_lockup_table/accounts/accounts/account_lookup_table.dart';

/// Enum representing different solana versioned transaction types.
class TransactionType {
  final String name;
  const TransactionType._(this.name);

  /// Version 0 transaction type.
  static const TransactionType v0 = TransactionType._('V0');

  /// Version 1 transaction type (SIMD-0385: `0x81` prefix, signatures at
  /// the transaction tail, native message config, no address lookup tables,
  /// 4096-byte limit).
  static const TransactionType v1 = TransactionType._('V1');

  /// Legacy transaction type.
  static const TransactionType legacy = TransactionType._('legacy');

  static TransactionType find(dynamic v) {
    if (v == null) return TransactionType.legacy;
    if (v is int && v == 0) return TransactionType.v0;
    if (v is int && v == 1) return TransactionType.v1;
    if (v is String) {
      if (v.toLowerCase() == legacy.name) {
        return legacy;
      } else if (v.toLowerCase() == v0.name.toLowerCase()) {
        return v0;
      } else if (v.toLowerCase() == v1.name.toLowerCase()) {
        return v1;
      }
    }
    throw BuError(
      DefaultErrorType.invalidArgument,
      'Invalid versioned transaction type.',
      details: {'value': v?.toString()},
    );
  }

  @override
  String toString() {
    return 'TransactionType.$name';
  }
}

/// Abstract class representing a versioned message.
abstract class VersionedMessage {
  VersionedMessage copyWith({
    MessageHeader? header,
    List<SolAddress>? accountKeys,
    SolAddress? recentBlockhash,
    List<CompiledInstruction>? compiledInstructions,
    List<AddressTableLookup>? addressTableLookups,
  });

  /// The message header, identifying signed and read-only [accountKeys].
  abstract final MessageHeader header;

  /// All the account keys used by this transaction.
  abstract final List<SolAddress> accountKeys;

  /// Instructions that will be executed in sequence and committed in one atomic transaction if all succeed..
  abstract final List<CompiledInstruction> compiledInstructions;

  /// The hash of a recent ledger block.
  abstract final SolAddress recentBlockhash;

  /// Constructs a versioned message from a serialized buffer.
  factory VersionedMessage.fromBuffer(List<int> serializedMessage) {
    if (serializedMessage.isEmpty) {
      throw const BuError(
        OnChainErrorType.solanaPlugin,
        'Empty serialized message bytes.',
      );
    }
    final int prefix = serializedMessage[0];
    if ((prefix & SolanaTransactionConstant.versionPrefixV0) == 0) {
      return Message.fromBuffer(serializedMessage);
    }
    final int version = prefix & SolanaTransactionConstant.versionPrefixMask;
    if (version == 0) return MessageV0.fromBuffer(serializedMessage);
    if (version == 1) return MessageV1.fromBuffer(serializedMessage);
    throw BuError(
      DefaultErrorType.unsupported,
      'Unsupported versioned message version.',
      details: {'version': version.toString()},
    );
  }

  /// Gets the accounts associated with the message.
  MessageAccountKeys getAccounts({
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
    AccountLookupKeys? lookupKeys,
  });

  /// Gets the version of the message.
  TransactionType get version;

  /// Serializes the message.
  List<int> serialize();

  /// Checks if an account at the specified index is a signer.
  bool isAccountSigner(int index);

  /// Checks if an account at the specified index is writable.
  bool isAccountWritable(int index);

  /// Constructs a legacy versioned message.
  factory VersionedMessage.toLegacy({
    required SolAddress payerKey,
    required SolAddress recentBlockhash,
    required List<TransactionInstruction> instructions,
  }) {
    return Message.compile(
      transactionInstructions: instructions,
      payer: payerKey,
      recentBlockhash: recentBlockhash,
    );
  }

  /// Constructs a version 0 versioned message.
  factory VersionedMessage.toV0({
    required SolAddress payerKey,
    required SolAddress recentBlockhash,
    required List<TransactionInstruction> instructions,
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
  }) {
    return MessageV0.compile(
      transactionInstructions: instructions,
      payer: payerKey,
      recentBlockhash: recentBlockhash,
      lookupTableAccounts: addressLookupTableAccounts,
    );
  }

  /// Constructs a v1 versioned message (SIMD-0385).
  factory VersionedMessage.toV1({
    required SolAddress payerKey,
    required SolAddress recentBlockhash,
    required List<TransactionInstruction> instructions,
    TransactionV1Config config = const TransactionV1Config.empty(),
  }) {
    return MessageV1.compile(
      transactionInstructions: instructions,
      payer: payerKey,
      recentBlockhash: recentBlockhash,
      config: config,
    );
  }

  /// Constructs a versioned message from JSON (RPC `getTransaction` /
  /// `getBlock` message object).
  factory VersionedMessage.fromJson(
    Map<String, dynamic> json, {
    TransactionType? type,

    /// Resolved LUT addresses from `meta.loadedAddresses`. The message itself
    /// only carries lookup *indexes* — without these the dynamic keys cannot
    /// be rebuilt and re-compiled indexes diverge from the wire bytes.
    AccountLookupKeys? resolvedLookupKeys,
  }) {
    final List<AddressTableLookup> addressTableLookups =
        (json['addressTableLookups'] as List?)
            ?.map((e) => AddressTableLookup.fromJson(e))
            .toList() ??
        [];
    final List<SolAddress> writable =
        addressTableLookups
            .map(
              (e) =>
                  List.generate(e.writableIndexes.length, (i) => e.accountKey),
            )
            .expand((element) => element)
            .toList();
    final List<SolAddress> readonly =
        addressTableLookups
            .map(
              (e) =>
                  List.generate(e.readonlyIndexes.length, (i) => e.accountKey),
            )
            .expand((element) => element)
            .toList();
    final AccountLookupKeys? accountLookupKeys =
        resolvedLookupKeys ??
        (addressTableLookups.isEmpty
            ? null
            : AccountLookupKeys(readonly: readonly, writable: writable));
    final List<SolAddress> staticAccounts =
        (json['accountKeys'] as List)
            .map(
              // Picks up the `jsonParsed` accountKeys object shape
              // `{pubkey, signer, source, writable}` (was: base58 strings only).
              (e) => SolAddress.uncheckCurve(e is Map ? e['pubkey'] : e),
            )
            .toList();
    final msg = MessageAccountKeys(staticAccounts, accountLookupKeys);
    // Picks up `jsonParsed` messages which omit `header` (signer /
    // writable flags ride inline on the accountKeys objects). The header is
    // derived from canonical account ordering when absent.
    final messageHeader =
        json['header'] == null
            ? MessageHeader(
              numRequiredSignatures:
                  (json['accountKeys'] as List)
                      .where((e) => e is Map && e['signer'] == true)
                      .length,
              numReadonlySignedAccounts:
                  (json['accountKeys'] as List)
                      .where(
                        (e) =>
                            e is Map &&
                            e['signer'] == true &&
                            e['writable'] != true,
                      )
                      .length,
              numReadonlyUnsignedAccounts:
                  (json['accountKeys'] as List)
                      .where(
                        (e) =>
                            e is Map &&
                            e['signer'] != true &&
                            e['writable'] != true,
                      )
                      .length,
            )
            : MessageHeader.fromJson(
              (json['header'] as Map).cast<String, dynamic>(),
            );
    final instructions = (json['instructions'] as List).map((e) {
      // Picks up the `jsonParsed` instruction shapes
      // (`{program, programId, parsed, ...}` /
      // `{programId, accounts: string[], data, ...}`).
      // Keys/data stay best-effort: fetched history is for display, the
      // authoritative `parsed` payload is preserved on the instruction.
      if (!e.containsKey('programIdIndex')) {
        final parsed = ParsedInstruction.fromJson(e);
        List<int> data = const [];
        try {
          if (parsed.data != null) {
            data = SolanaRequestEncoding.decode(parsed.data);
          }
        } catch (_) {}
        return TransactionInstruction(
          programId: parsed.programId,
          keys:
              parsed.accounts
                  .map(
                    (a) => AccountMeta(
                      publicKey: SolAddress.uncheckCurve(a),
                      isSigner: false,
                      isWritable: false,
                    ),
                  )
                  .toList(),
          data: data,
          parsed: {
            if (parsed.program != null) 'program': parsed.program,
            if (parsed.parsed != null) 'parsed': parsed.parsed,
          },
        );
      }
      final List<int> accountMetaKeys = (e['accounts'] as List).cast();
      final instruction = TransactionInstruction(
        programId: msg.byIndex(e['programIdIndex'])!,
        keys:
            accountMetaKeys.map((i) {
              return AccountMeta(
                publicKey: msg.byIndex(i)!,
                isSigner: messageHeader.isAccountSigner(i),
                isWritable: messageHeader.isAccountWritable(
                  index: i,
                  numStaticAccountKeys: staticAccounts.length,
                  addressTableLookups: addressTableLookups,
                ),
              );
            }).toList(),
        data: SolanaRequestEncoding.decode(e['data']),
      );
      return instruction;
    });
    final bool isV1 =
        type == TransactionType.v1 ||
        (type == null &&
            addressTableLookups.isEmpty &&
            json['transactionConfig'] is Map);
    if (isV1) {
      if (addressTableLookups.isNotEmpty) {
        throw const BuError(
          DefaultErrorType.unsupported,
          'V1 transactions do not support address lookup tables.',
        );
      }
      final configJson = json['transactionConfig'];
      final config =
          configJson is Map
              ? TransactionV1Config.fromJson(
                Map<String, dynamic>.from(configJson),
              )
              : const TransactionV1Config.empty();
      return MessageV1(
        header: messageHeader,
        accountKeys: staticAccounts,
        recentBlockhash: SolAddress.uncheckCurve(
          json['recentBlockhash'] ?? json['lifetimeSpecifier'],
        ),
        compiledInstructions: msg.compileInstructions(instructions.toList()),
        config: config,
      );
    }
    if (type == TransactionType.v0 ||
        (type == null && addressTableLookups.isNotEmpty)) {
      return MessageV0(
        header: messageHeader,
        accountKeys: staticAccounts,
        recentBlockhash: SolAddress.uncheckCurve(json['recentBlockhash']),
        compiledInstructions: msg.compileInstructions(instructions.toList()),
        addressTableLookups: addressTableLookups,
      );
    }
    return Message(
      accountKeys: staticAccounts,
      compiledInstructions: msg.compileInstructions(instructions.toList()),
      header: messageHeader,
      recentBlockhash: SolAddress.uncheckCurve(json['recentBlockhash']),
    );
  }
}

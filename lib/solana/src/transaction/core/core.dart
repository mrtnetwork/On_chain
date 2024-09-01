import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/rpc/models/models/encoding.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';
import 'package:on_chain/solana/src/transaction/message/legacy.dart';
import 'package:on_chain/solana/src/transaction/message/message_v0.dart';

/// Enum representing different solana versioned transaction types.
class TransactionType {
  final String name;
  const TransactionType._(this.name);

  /// Version 0 transaction type.
  static const TransactionType v0 = TransactionType._("V0");

  /// Legacy transaction type.
  static const TransactionType legacy = TransactionType._("legacy");

  static TransactionType find(dynamic v) {
    if (v == null) return TransactionType.legacy;
    if (v is int && v == 0) return TransactionType.v0;
    if (v is String) {
      if (v.toLowerCase() == legacy.name) {
        return legacy;
      } else if (v.toLowerCase() == v0.name.toLowerCase()) {
        return v0;
      }
    }
    throw SolanaPluginException("Invalid Versioned transaction type",
        details: {"value": v});
  }

  @override
  String toString() {
    return "TransactionType.$name";
  }
}

/// Abstract class representing a versioned message.
abstract class VersionedMessage {
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
    int prefix = serializedMessage[0];
    int maskedPrefix = prefix & SolanaTransactionConstant.versionPrefixMask;
    if (maskedPrefix == prefix) {
      return Message.fromBuffer(serializedMessage);
    }
    return MessageV0.fromBuffer(serializedMessage);
  }

  /// Gets the accounts associated with the message.
  MessageAccountKeys getAccounts(
      {List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
      AccountLookupKeys? lookupKeys});

  /// Gets the version of the message.
  TransactionType get version;

  /// Serializes the message.
  List<int> serialize();

  /// Checks if an account at the specified index is a signer.
  bool isAccountSigner(int index);

  /// Checks if an account at the specified index is writable.
  bool isAccountWritable(int index);

  /// Constructs a legacy versioned message.
  factory VersionedMessage.toLegacy(
      {required SolAddress payerKey,
      required SolAddress recentBlockhash,
      required List<TransactionInstruction> instructions}) {
    return Message.compile(
        transactionInstructions: instructions,
        payer: payerKey,
        recentBlockhash: recentBlockhash);
  }

  /// Constructs a version 0 versioned message.
  factory VersionedMessage.toV0(
      {required SolAddress payerKey,
      required SolAddress recentBlockhash,
      required List<TransactionInstruction> instructions,
      List<AddressLookupTableAccount> addressLookupTableAccounts = const []}) {
    return MessageV0.compile(
        transactionInstructions: instructions,
        payer: payerKey,
        recentBlockhash: recentBlockhash,
        lookupTableAccounts: addressLookupTableAccounts);
  }

  /// Constructs a version 0 versioned message.
  factory VersionedMessage.fromJson(Map<String, dynamic> json,
      {TransactionType? type}) {
    final List<AddressTableLookup> addressTableLookups =
        (json["addressTableLookups"] as List?)
                ?.map((e) => AddressTableLookup.fromJson(e))
                .toList() ??
            [];
    final List<SolAddress> writable = addressTableLookups
        .map(
            (e) => List.generate(e.writableIndexes.length, (i) => e.accountKey))
        .expand((element) => element)
        .toList();
    final List<SolAddress> readonly = addressTableLookups
        .map(
            (e) => List.generate(e.readonlyIndexes.length, (i) => e.accountKey))
        .expand((element) => element)
        .toList();
    final AccountLookupKeys? accountLookupKeys = (addressTableLookups.isEmpty)
        ? null
        : AccountLookupKeys(readonly: readonly, writable: writable);
    final List<SolAddress> staticAccounts = (json["accountKeys"] as List)
        .map((e) => SolAddress.uncheckCurve(e))
        .toList();
    final msg = MessageAccountKeys(staticAccounts, accountLookupKeys);
    final messageHeader = MessageHeader.fromJson(json["header"]);
    final instructions = (json["instructions"] as List).map((e) {
      final List<int> accountMetaKeys = (e["accounts"] as List).cast();
      final instruction = TransactionInstruction(
          programId: msg.byIndex(e["programIdIndex"])!,
          keys: accountMetaKeys.map((i) {
            return AccountMeta(
                publicKey: msg.byIndex(i)!,
                isSigner: messageHeader.isAccountSigner(i),
                isWritable: messageHeader.isAccountWritable(
                    index: i,
                    numStaticAccountKeys: staticAccounts.length,
                    addressTableLookups: addressTableLookups));
          }).toList(),
          data: SolanaRPCEncoding.decode(e["data"]));
      return instruction;
    });
    if (type == TransactionType.v0 ||
        (type == null && addressTableLookups.isNotEmpty)) {
      return MessageV0(
          header: messageHeader,
          accountKeys: staticAccounts,
          recentBlockhash: SolAddress.uncheckCurve(json["recentBlockhash"]),
          compiledInstructions: msg.compileInstructions(instructions.toList()),
          addressTableLookups: addressTableLookups);
    }
    return Message(
      accountKeys: staticAccounts,
      compiledInstructions: msg.compileInstructions(instructions.toList()),
      header: messageHeader,
      recentBlockhash: SolAddress.uncheckCurve(json["recentBlockhash"]),
    );
  }
}

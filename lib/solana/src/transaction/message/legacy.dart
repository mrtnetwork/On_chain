import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/transaction/core/core.dart';
import 'package:on_chain/solana/src/transaction/utils/utils.dart';

/// A class representing a legacy Solana message.
class Message implements VersionedMessage {
  /// The header of the message.
  @override
  final MessageHeader header;

  /// The account keys associated with the message.
  @override
  final List<SolAddress> accountKeys;

  /// The recent blockhash associated with the message.
  @override
  final SolAddress recentBlockhash;

  /// The compiled instructions of the message.
  @override
  final List<CompiledInstruction> compiledInstructions;

  /// Constructs a [Message] with required parameters.
  const Message({
    required this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.compiledInstructions,
  });

  @override
  Message copyWith(
      {MessageHeader? header,
      List<SolAddress>? accountKeys,
      SolAddress? recentBlockhash,
      List<CompiledInstruction>? compiledInstructions,
      List<AddressTableLookup>? addressTableLookups}) {
    return Message(
        header: header ?? this.header,
        accountKeys: accountKeys ?? this.accountKeys,
        recentBlockhash: recentBlockhash ?? this.recentBlockhash,
        compiledInstructions:
            compiledInstructions ?? this.compiledInstructions);
  }

  /// Constructs a message from a serialized buffer.
  factory Message.fromBuffer(List<int> buffer) {
    return SolanaTransactionUtils.deserializeMessageLegacy(buffer);
  }

  /// Compiles a legacy message from provided parameters.
  factory Message.compile({
    required List<TransactionInstruction> transactionInstructions,
    required SolAddress payer,
    required SolAddress recentBlockhash,
  }) {
    return SolanaTransactionUtils.compileLegacy(
      transactionInstructions: transactionInstructions,
      payer: payer,
      recentBlockhash: recentBlockhash,
    );
  }

  /// Gets the version of the message.
  @override
  TransactionType get version => TransactionType.legacy;

  /// Gets the static account keys associated with the message.
  List<SolAddress> get staticAccountKeys => accountKeys;

  /// Gets the accounts associated with the message.
  @override
  MessageAccountKeys getAccounts({
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
    AccountLookupKeys? lookupKeys,
  }) {
    return MessageAccountKeys(staticAccountKeys, null);
  }

  /// Checks if an account at the specified index is a signer.
  @override
  bool isAccountSigner(int index) => header.isAccountSigner(index);

  /// Checks if an account at the specified index is writable.
  @override
  bool isAccountWritable(int index) => header.isAccountWritable(
      index: index,
      numStaticAccountKeys: accountKeys.length,
      addressTableLookups: const []);

  /// Serializes the message.
  @override
  List<int> serialize() {
    return SolanaTransactionUtils.serializeLegacy(this);
  }

  /// Serializes the message to hexadecimal format.
  String serializeHex() {
    return BytesUtils.toHexString(serialize());
  }
}
